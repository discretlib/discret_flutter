use std::sync::Arc;
use std::{fs, path::PathBuf};

use crate::messages;
use discret::{
    base64_decode, base64_encode, database_exists, derive_pass_phrase, hash, Configuration,
    DefaultRoom, Discret, Parameters,
};
use messages::discret::*;
use serde_json::json;
use std::error::Error;
use tokio::sync::{Mutex, Notify};

pub type Result<T> = std::result::Result<T, Box<dyn Error + Send + Sync>>;

pub async fn connect(
    discret: Arc<Mutex<Option<Discret>>>,
    discret_started: Arc<Notify>,
) -> Result<()> {
    let mut receiver = Connect::get_dart_signal_receiver()?;
    while let Some(dart_signal) = receiver.recv().await {
        let query = dart_signal.message;

        //value used to derives all necessary secrets
        let key_material = hash(&query.key_material);

        //check that the database exists

        start_discret(
            query.id,
            query.application_name,
            query.data_model,
            query.allow_create,
            key_material,
            query.data_path,
            query.configuration,
            &discret,
            &discret_started,
        )
        .await;
    }

    Ok(())
}

pub async fn login(
    discret: Arc<Mutex<Option<Discret>>>,
    discret_started: Arc<Notify>,
) -> Result<()> {
    let mut receiver = Login::get_dart_signal_receiver()?;
    while let Some(dart_signal) = receiver.recv().await {
        let query = dart_signal.message;

        //value used to derives all necessary secrets
        let key_material = derive_pass_phrase(&query.username, &query.password);

        start_discret(
            query.id,
            query.application_name,
            query.data_model,
            query.allow_create,
            key_material,
            query.data_path,
            query.configuration,
            &discret,
            &discret_started,
        )
        .await;
    }
    Ok(())
}

pub async fn query(discret: Arc<Mutex<Option<Discret>>>) -> Result<()> {
    let mut receiver = Query::get_dart_signal_receiver()?;
    while let Some(dart_signal) = receiver.recv().await {
        let discret = discret.lock().await;
        let app = discret.clone();
        drop(discret);

        let query = dart_signal.message;
        match app {
            Some(app) => {
                let res = do_query(&query.query, &query.parameters, app).await;
                match res {
                    Ok(res) => {
                        ResultMsg {
                            id: query.id,
                            successful: true,
                            error: "".to_string(),
                            data: res,
                        }
                        .send_signal_to_dart();
                    }
                    Err(err) => {
                        ResultMsg {
                            id: query.id,
                            successful: false,
                            error: err.to_string(),
                            data: "".to_string(),
                        }
                        .send_signal_to_dart();
                    }
                }
            }
            None => {
                ResultMsg {
                    id: query.id,
                    successful: false,
                    error: "Discret is not initialized".to_string(),
                    data: "".to_string(),
                }
                .send_signal_to_dart();
            }
        }
    }
    Ok(())
}

pub async fn mutate(discret: Arc<Mutex<Option<Discret>>>) -> Result<()> {
    let mut receiver = Mutate::get_dart_signal_receiver()?;
    while let Some(dart_signal) = receiver.recv().await {
        let discret = discret.lock().await;
        let app = discret.clone();
        drop(discret);

        let query = dart_signal.message;
        match app {
            Some(app) => {
                let res = do_mutate(&query.query, &query.parameters, app).await;
                match res {
                    Ok(res) => {
                        ResultMsg {
                            id: query.id,
                            successful: true,
                            error: "".to_string(),
                            data: res,
                        }
                        .send_signal_to_dart();
                    }
                    Err(err) => {
                        ResultMsg {
                            id: query.id,
                            successful: false,
                            error: err.to_string(),
                            data: "".to_string(),
                        }
                        .send_signal_to_dart();
                    }
                }
            }
            None => {
                ResultMsg {
                    id: query.id,
                    successful: false,
                    error: "Discret is not initialized".to_string(),
                    data: "".to_string(),
                }
                .send_signal_to_dart();
            }
        }
    }
    Ok(())
}

pub async fn delete(discret: Arc<Mutex<Option<Discret>>>) -> Result<()> {
    let mut receiver = Delete::get_dart_signal_receiver()?;
    while let Some(dart_signal) = receiver.recv().await {
        let discret = discret.lock().await;
        let app = discret.clone();
        drop(discret);

        let query = dart_signal.message;
        println!("{}", query.id);
        println!("{}", query.query);
        match app {
            Some(app) => {
                let res = do_delete(&query.query, &query.parameters, app).await;
                match res {
                    Ok(_) => {
                        ResultMsg {
                            id: query.id,
                            successful: true,
                            error: "".to_string(),
                            data: "".to_string(),
                        }
                        .send_signal_to_dart();
                    }
                    Err(err) => {
                        ResultMsg {
                            id: query.id,
                            successful: false,
                            error: err.to_string(),
                            data: "".to_string(),
                        }
                        .send_signal_to_dart();
                    }
                }
            }
            None => {
                ResultMsg {
                    id: query.id,
                    successful: false,
                    error: "Discret is not initialized".to_string(),
                    data: "".to_string(),
                }
                .send_signal_to_dart();
            }
        }
    }
    Ok(())
}

pub async fn private_room(discret: Arc<Mutex<Option<Discret>>>) -> Result<()> {
    let mut receiver = PrivateRoom::get_dart_signal_receiver()?;
    while let Some(dart_signal) = receiver.recv().await {
        let discret = discret.lock().await;
        let app = discret.clone();
        drop(discret);

        let query = dart_signal.message;
        match app {
            Some(app) => {
                let room = app.private_room();
                ResultMsg {
                    id: query.id,
                    successful: true,
                    error: "".to_string(),
                    data: room,
                }
                .send_signal_to_dart();
            }
            None => {
                ResultMsg {
                    id: query.id,
                    successful: false,
                    error: "Discret is not initialized".to_string(),
                    data: "".to_string(),
                }
                .send_signal_to_dart();
            }
        }
    }
    Ok(())
}

pub async fn verifying_key(discret: Arc<Mutex<Option<Discret>>>) -> Result<()> {
    let mut receiver = VerifyingKey::get_dart_signal_receiver()?;
    while let Some(dart_signal) = receiver.recv().await {
        let discret = discret.lock().await;
        let app = discret.clone();
        drop(discret);

        let query = dart_signal.message;
        match app {
            Some(app) => {
                let key = app.verifying_key();
                ResultMsg {
                    id: query.id,
                    successful: true,
                    error: "".to_string(),
                    data: key,
                }
                .send_signal_to_dart();
            }
            None => {
                ResultMsg {
                    id: query.id,
                    successful: false,
                    error: "Discret is not initialized".to_string(),
                    data: "".to_string(),
                }
                .send_signal_to_dart();
            }
        }
    }
    Ok(())
}

pub async fn invite(discret: Arc<Mutex<Option<Discret>>>) -> Result<()> {
    let mut receiver = Invite::get_dart_signal_receiver()?;
    while let Some(dart_signal) = receiver.recv().await {
        let discret = discret.lock().await;
        let app = discret.clone();
        drop(discret);

        let query = dart_signal.message;
        match app {
            Some(app) => {
                let default_room = DefaultRoom {
                    room: query.room,
                    authorisation: query.authorisation,
                };
                let invite_res = app.invite(Some(default_room)).await;
                match invite_res {
                    Ok(invite) => {
                        let invite = base64_encode(&invite);
                        ResultMsg {
                            id: query.id,
                            successful: true,
                            error: "".to_string(),
                            data: invite,
                        }
                        .send_signal_to_dart();
                    }
                    Err(err) => {
                        ResultMsg {
                            id: query.id,
                            successful: false,
                            error: err.to_string(),
                            data: "".to_string(),
                        }
                        .send_signal_to_dart();
                    }
                }
            }
            None => {
                ResultMsg {
                    id: query.id,
                    successful: false,
                    error: "Discret is not initialized".to_string(),
                    data: "".to_string(),
                }
                .send_signal_to_dart();
            }
        }
    }
    Ok(())
}

pub async fn accept_invite(discret: Arc<Mutex<Option<Discret>>>) -> Result<()> {
    let mut receiver = AcceptInvite::get_dart_signal_receiver()?;
    while let Some(dart_signal) = receiver.recv().await {
        let discret = discret.lock().await;
        let app = discret.clone();
        drop(discret);

        let query = dart_signal.message;
        match app {
            Some(app) => {
                let invite_res = do_accept_invite(&query.invite, app).await;
                match invite_res {
                    Ok(_) => {
                        ResultMsg {
                            id: query.id,
                            successful: true,
                            error: "".to_string(),
                            data: "".to_string(),
                        }
                        .send_signal_to_dart();
                    }
                    Err(err) => {
                        ResultMsg {
                            id: query.id,
                            successful: false,
                            error: err.to_string(),
                            data: "".to_string(),
                        }
                        .send_signal_to_dart();
                    }
                }
            }
            None => {
                ResultMsg {
                    id: query.id,
                    successful: false,
                    error: "Discret is not initialized".to_string(),
                    data: "".to_string(),
                }
                .send_signal_to_dart();
            }
        }
    }
    Ok(())
}

pub async fn data_model(discret: Arc<Mutex<Option<Discret>>>) -> Result<()> {
    let mut receiver = DataModel::get_dart_signal_receiver()?;
    while let Some(dart_signal) = receiver.recv().await {
        let discret = discret.lock().await;
        let app = discret.clone();
        drop(discret);

        let query = dart_signal.message;
        match app {
            Some(app) => {
                let datamodel = app.data_model().await;
                match datamodel {
                    Ok(datamodel) => {
                        ResultMsg {
                            id: query.id,
                            successful: true,
                            error: "".to_string(),
                            data: datamodel,
                        }
                        .send_signal_to_dart();
                    }
                    Err(err) => {
                        ResultMsg {
                            id: query.id,
                            successful: false,
                            error: err.to_string(),
                            data: "".to_string(),
                        }
                        .send_signal_to_dart();
                    }
                }
            }
            None => {
                ResultMsg {
                    id: query.id,
                    successful: false,
                    error: "Discret is not initialized".to_string(),
                    data: "".to_string(),
                }
                .send_signal_to_dart();
            }
        }
    }
    Ok(())
}

pub async fn update_data_model(discret: Arc<Mutex<Option<Discret>>>) -> Result<()> {
    let mut receiver = UpdateDataModel::get_dart_signal_receiver()?;
    while let Some(dart_signal) = receiver.recv().await {
        let discret = discret.lock().await;
        let app = discret.clone();
        drop(discret);

        let query = dart_signal.message;
        match app {
            Some(app) => {
                let datamodel = app.update_data_model(&query.datamodel).await;
                match datamodel {
                    Ok(datamodel) => {
                        ResultMsg {
                            id: query.id,
                            successful: true,
                            error: "".to_string(),
                            data: datamodel,
                        }
                        .send_signal_to_dart();
                    }
                    Err(err) => {
                        ResultMsg {
                            id: query.id,
                            successful: false,
                            error: err.to_string(),
                            data: "".to_string(),
                        }
                        .send_signal_to_dart();
                    }
                }
            }
            None => {
                ResultMsg {
                    id: query.id,
                    successful: false,
                    error: "Discret is not initialized".to_string(),
                    data: "".to_string(),
                }
                .send_signal_to_dart();
            }
        }
    }
    Ok(())
}

pub async fn event_listener(
    discret: Arc<Mutex<Option<Discret>>>,
    discret_started: Arc<Notify>,
) -> Result<()> {
    discret_started.notified().await;
    let discret = discret.lock().await;
    let app = discret.clone().unwrap();
    drop(discret);

    let mut events = app.subscribe_for_events().await;
    while let Ok(event) = events.recv().await {
        match event {
            discret::Event::DataChanged(data) => {
                let data = serde_json::to_string(&*data);
                if let Ok(data) = data {
                    EventMsg {
                        event: "DataChanged".to_string(),
                        data: data,
                    }
                    .send_signal_to_dart();
                }
            }
            discret::Event::RoomModified(room) => {
                let room_id = base64_encode(&room.id);
                EventMsg {
                    event: "RoomModified".to_string(),
                    data: room_id,
                }
                .send_signal_to_dart();
            }
            discret::Event::RoomSynchronized(room) => {
                EventMsg {
                    event: "RoomSynchronized".to_string(),
                    data: room,
                }
                .send_signal_to_dart();
            }

            discret::Event::PeerConnected(verifying_key, date, connection_id) => {
                let verifying_key = base64_encode(&verifying_key);
                let peer = json!({
                    "verifyingKey": verifying_key,
                    "date":date,
                    "connectionId": connection_id
                });
                let data = serde_json::to_string(&peer);

                if let Ok(data) = data {
                    EventMsg {
                        event: "PeerConnected".to_string(),
                        data: data,
                    }
                    .send_signal_to_dart();
                }
            }
            discret::Event::PeerDisconnected(verifying_key, date, connection_id) => {
                let verifying_key = base64_encode(&verifying_key);
                let peer = json!({
                    "verifyingKey": verifying_key,
                    "date":date,
                    "connectionId": connection_id
                });
                let data = serde_json::to_string(&peer);

                if let Ok(data) = data {
                    EventMsg {
                        event: "PeerDisconnected".to_string(),
                        data: data,
                    }
                    .send_signal_to_dart();
                }
            }

            discret::Event::PendingPeer() => {
                EventMsg {
                    event: "PendingPeer".to_string(),
                    data: "{}".to_string(),
                }
                .send_signal_to_dart();
            }
            discret::Event::PendingHardware() => {
                EventMsg {
                    event: "PendingHardware".to_string(),
                    data: "{}".to_string(),
                }
                .send_signal_to_dart();
            }
        }
    }

    Ok(())
}

pub async fn log_listener(
    discret: Arc<Mutex<Option<Discret>>>,
    discret_started: Arc<Notify>,
) -> Result<()> {
    discret_started.notified().await;
    let discret = discret.lock().await;
    let app = discret.clone().unwrap();
    drop(discret);
    let mut logs = app.subscribe_for_logs().await;
    while let Ok(log) = logs.recv().await {
        match log {
            discret::Log::Info(date, message) => {
                let peer = json!({
                    "date":date,
                    "message": message
                });
                let data = serde_json::to_string(&peer);

                if let Ok(data) = data {
                    LogMsg {
                        level: "Info".to_string(),
                        data: data,
                    }
                    .send_signal_to_dart();
                }
            }
            discret::Log::Error(date, source, message) => {
                let peer = json!({
                    "date":date,
                    "source":source,
                    "message": message
                });
                let data = serde_json::to_string(&peer);

                if let Ok(data) = data {
                    LogMsg {
                        level: "Error".to_string(),
                        data: data,
                    }
                    .send_signal_to_dart();
                }
            }
        }
    }
    Ok(())
}

async fn start_discret(
    id: i32,
    application_name: String,
    data_model: String,
    create: bool,
    key_material: [u8; 32],
    path: String,
    configuration: String,
    discret: &Arc<Mutex<Option<Discret>>>,
    discret_started: &Arc<Notify>,
) {
    fs::create_dir_all(path.clone()).unwrap();

    let conf: std::result::Result<Configuration, toml::de::Error> = toml::from_str(&configuration);
    let configuration = match conf {
        Ok(conf) => conf,
        Err(err) => {
            ResultMsg {
                id,
                successful: false,
                error: err.to_string(),
                data: "".to_string(),
            }
            .send_signal_to_dart();
            return;
        }
    };

    let data_path: PathBuf = path.clone().into();
    let exists_result = database_exists(&application_name, &key_material, &data_path);
    //check that the database exists

    match exists_result {
        Ok(exist) => {
            if !exist && !create {
                ResultMsg {
                    id,
                    successful: false,
                    error: "Invalid Credentials".to_string(),
                    data: "".to_string(),
                }
                .send_signal_to_dart();
                return;
            }
            if exist && create {
                ResultMsg {
                    id,
                    successful: false,
                    error: "Account Already Exists".to_string(),
                    data: "".to_string(),
                }
                .send_signal_to_dart();
                return;
            }
        }
        Err(err) => {
            ResultMsg {
                id: id,
                successful: false,
                error: err.to_string(),
                data: "".to_string(),
            }
            .send_signal_to_dart();
            return;
        }
    }

    let app_res = Discret::new(
        &data_model,
        &application_name,
        &key_material,
        data_path,
        configuration,
    )
    .await;

    //start the discret application
    match app_res {
        Ok(app) => {
            let mut discret = discret.lock().await;
            *discret = Some(app);
            drop(discret);
            ResultMsg {
                id: id,
                successful: true,
                error: "".to_string(),
                data: "success".to_string(),
            }
            .send_signal_to_dart();
            discret_started.notify_waiters();
        }
        Err(err) => {
            ResultMsg {
                id: id,
                successful: false,
                error: err.to_string(),
                data: "".to_string(),
            }
            .send_signal_to_dart();
        }
    }
}

async fn do_query(
    query: &str,
    params: &str,
    app: Discret,
) -> std::result::Result<String, discret::Error> {
    let params = Parameters::from_json(params)?;
    app.query(query, Some(params)).await
}

async fn do_mutate(
    query: &str,
    params: &str,
    app: Discret,
) -> std::result::Result<String, discret::Error> {
    let params = Parameters::from_json(params)?;
    app.mutate(query, Some(params)).await
}

async fn do_delete(
    query: &str,
    params: &str,
    app: Discret,
) -> std::result::Result<(), discret::Error> {
    let params = Parameters::from_json(params)?;
    app.delete(query, Some(params)).await
}

async fn do_accept_invite(invite: &str, app: Discret) -> std::result::Result<(), discret::Error> {
    let invite = base64_decode(invite.as_bytes())?;
    app.accept_invite(invite).await
}
