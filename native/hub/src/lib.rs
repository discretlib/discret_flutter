//! This `hub` crate is the
//! entry point of the Rust logic.

mod discret_binding;
mod messages;

use std::sync::Arc;

use discret::Discret;
use discret_binding::{
    accept_invite, connect, data_model, delete, event_listener, invite, log_listener, login,
    mutate, private_room, query, update_data_model, verifying_key,
};
use tokio::{
    self,
    sync::{Mutex, Notify},
};

rinf::write_interface!();

async fn main() {
    let discret: Arc<Mutex<Option<Discret>>> = Arc::new(Mutex::new(None));
    let discret_started: Arc<Notify> = Arc::new(Notify::new());
    tokio::spawn(login(discret.clone(), discret_started.clone()));
    tokio::spawn(connect(discret.clone(), discret_started.clone()));
    tokio::spawn(event_listener(discret.clone(), discret_started.clone()));
    tokio::spawn(log_listener(discret.clone(), discret_started.clone()));
    tokio::spawn(query(discret.clone()));
    tokio::spawn(mutate(discret.clone()));
    tokio::spawn(delete(discret.clone()));
    tokio::spawn(private_room(discret.clone()));
    tokio::spawn(verifying_key(discret.clone()));
    tokio::spawn(invite(discret.clone()));
    tokio::spawn(accept_invite(discret.clone()));
    tokio::spawn(data_model(discret.clone()));
    tokio::spawn(update_data_model(discret.clone()));
}
