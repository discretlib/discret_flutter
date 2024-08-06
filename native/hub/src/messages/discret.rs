#![allow(unused_imports)]

use crate::tokio;
use prost::Message;
use rinf::{debug_print, send_rust_signal, DartSignal, RinfError};
use std::sync::Mutex;
use tokio::sync::mpsc::{unbounded_channel, UnboundedReceiver, UnboundedSender};


// @generated
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct Connect {
    #[prost(int32, tag="1")]
    pub id: i32,
    #[prost(bytes="vec", tag="2")]
    pub key_material: ::prost::alloc::vec::Vec<u8>,
    #[prost(bool, tag="3")]
    pub allow_create: bool,
    #[prost(string, tag="4")]
    pub application_name: ::prost::alloc::string::String,
    #[prost(string, tag="5")]
    pub data_path: ::prost::alloc::string::String,
    #[prost(string, tag="6")]
    pub data_model: ::prost::alloc::string::String,
    #[prost(string, tag="7")]
    pub configuration: ::prost::alloc::string::String,
}
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct Login {
    #[prost(int32, tag="1")]
    pub id: i32,
    #[prost(string, tag="2")]
    pub username: ::prost::alloc::string::String,
    #[prost(string, tag="3")]
    pub password: ::prost::alloc::string::String,
    #[prost(bool, tag="4")]
    pub allow_create: bool,
    #[prost(string, tag="5")]
    pub application_name: ::prost::alloc::string::String,
    #[prost(string, tag="6")]
    pub data_path: ::prost::alloc::string::String,
    #[prost(string, tag="7")]
    pub data_model: ::prost::alloc::string::String,
    #[prost(string, tag="8")]
    pub configuration: ::prost::alloc::string::String,
}
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct Query {
    #[prost(int32, tag="1")]
    pub id: i32,
    #[prost(string, tag="2")]
    pub query: ::prost::alloc::string::String,
    #[prost(string, tag="3")]
    pub parameters: ::prost::alloc::string::String,
}
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct Mutate {
    #[prost(int32, tag="1")]
    pub id: i32,
    #[prost(string, tag="2")]
    pub query: ::prost::alloc::string::String,
    #[prost(string, tag="3")]
    pub parameters: ::prost::alloc::string::String,
}
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct Delete {
    #[prost(int32, tag="1")]
    pub id: i32,
    #[prost(string, tag="2")]
    pub query: ::prost::alloc::string::String,
    #[prost(string, tag="3")]
    pub parameters: ::prost::alloc::string::String,
}
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct VerifyingKey {
    #[prost(int32, tag="1")]
    pub id: i32,
}
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct PrivateRoom {
    #[prost(int32, tag="1")]
    pub id: i32,
}
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct Invite {
    #[prost(int32, tag="1")]
    pub id: i32,
    #[prost(string, tag="2")]
    pub room: ::prost::alloc::string::String,
    #[prost(string, tag="3")]
    pub authorisation: ::prost::alloc::string::String,
}
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct AcceptInvite {
    #[prost(int32, tag="1")]
    pub id: i32,
    #[prost(string, tag="2")]
    pub invite: ::prost::alloc::string::String,
}
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct DataModel {
    #[prost(int32, tag="1")]
    pub id: i32,
}
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct UpdateDataModel {
    #[prost(int32, tag="1")]
    pub id: i32,
    #[prost(string, tag="2")]
    pub datamodel: ::prost::alloc::string::String,
}
/// \[RINF:DART-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct SetLogLevel {
    #[prost(int32, tag="1")]
    pub id: i32,
    #[prost(string, tag="2")]
    pub level: ::prost::alloc::string::String,
}
/// \[RINF:RUST-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct ResultMsg {
    #[prost(int32, tag="1")]
    pub id: i32,
    #[prost(bool, tag="2")]
    pub successful: bool,
    #[prost(string, tag="3")]
    pub error: ::prost::alloc::string::String,
    #[prost(string, tag="4")]
    pub data: ::prost::alloc::string::String,
}
/// \[RINF:RUST-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct EventMsg {
    #[prost(string, tag="1")]
    pub event: ::prost::alloc::string::String,
    #[prost(string, tag="2")]
    pub data: ::prost::alloc::string::String,
}
/// \[RINF:RUST-SIGNAL\]
#[allow(clippy::derive_partial_eq_without_eq)]
#[derive(Clone, PartialEq, ::prost::Message)]
pub struct LogMsg {
    #[prost(string, tag="1")]
    pub level: ::prost::alloc::string::String,
    #[prost(string, tag="2")]
    pub data: ::prost::alloc::string::String,
}
// @@protoc_insertion_point(module)

type ConnectCell = Mutex<Option<(
    UnboundedSender<DartSignal<Connect>>,
    Option<UnboundedReceiver<DartSignal<Connect>>>,
)>>;
pub static CONNECT_CHANNEL: ConnectCell =
    Mutex::new(None);

impl Connect {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = CONNECT_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

type LoginCell = Mutex<Option<(
    UnboundedSender<DartSignal<Login>>,
    Option<UnboundedReceiver<DartSignal<Login>>>,
)>>;
pub static LOGIN_CHANNEL: LoginCell =
    Mutex::new(None);

impl Login {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = LOGIN_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

type QueryCell = Mutex<Option<(
    UnboundedSender<DartSignal<Query>>,
    Option<UnboundedReceiver<DartSignal<Query>>>,
)>>;
pub static QUERY_CHANNEL: QueryCell =
    Mutex::new(None);

impl Query {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = QUERY_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

type MutateCell = Mutex<Option<(
    UnboundedSender<DartSignal<Mutate>>,
    Option<UnboundedReceiver<DartSignal<Mutate>>>,
)>>;
pub static MUTATE_CHANNEL: MutateCell =
    Mutex::new(None);

impl Mutate {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = MUTATE_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

type DeleteCell = Mutex<Option<(
    UnboundedSender<DartSignal<Delete>>,
    Option<UnboundedReceiver<DartSignal<Delete>>>,
)>>;
pub static DELETE_CHANNEL: DeleteCell =
    Mutex::new(None);

impl Delete {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = DELETE_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

type VerifyingKeyCell = Mutex<Option<(
    UnboundedSender<DartSignal<VerifyingKey>>,
    Option<UnboundedReceiver<DartSignal<VerifyingKey>>>,
)>>;
pub static VERIFYING_KEY_CHANNEL: VerifyingKeyCell =
    Mutex::new(None);

impl VerifyingKey {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = VERIFYING_KEY_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

type PrivateRoomCell = Mutex<Option<(
    UnboundedSender<DartSignal<PrivateRoom>>,
    Option<UnboundedReceiver<DartSignal<PrivateRoom>>>,
)>>;
pub static PRIVATE_ROOM_CHANNEL: PrivateRoomCell =
    Mutex::new(None);

impl PrivateRoom {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = PRIVATE_ROOM_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

type InviteCell = Mutex<Option<(
    UnboundedSender<DartSignal<Invite>>,
    Option<UnboundedReceiver<DartSignal<Invite>>>,
)>>;
pub static INVITE_CHANNEL: InviteCell =
    Mutex::new(None);

impl Invite {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = INVITE_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

type AcceptInviteCell = Mutex<Option<(
    UnboundedSender<DartSignal<AcceptInvite>>,
    Option<UnboundedReceiver<DartSignal<AcceptInvite>>>,
)>>;
pub static ACCEPT_INVITE_CHANNEL: AcceptInviteCell =
    Mutex::new(None);

impl AcceptInvite {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = ACCEPT_INVITE_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

type DataModelCell = Mutex<Option<(
    UnboundedSender<DartSignal<DataModel>>,
    Option<UnboundedReceiver<DartSignal<DataModel>>>,
)>>;
pub static DATA_MODEL_CHANNEL: DataModelCell =
    Mutex::new(None);

impl DataModel {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = DATA_MODEL_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

type UpdateDataModelCell = Mutex<Option<(
    UnboundedSender<DartSignal<UpdateDataModel>>,
    Option<UnboundedReceiver<DartSignal<UpdateDataModel>>>,
)>>;
pub static UPDATE_DATA_MODEL_CHANNEL: UpdateDataModelCell =
    Mutex::new(None);

impl UpdateDataModel {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = UPDATE_DATA_MODEL_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

type SetLogLevelCell = Mutex<Option<(
    UnboundedSender<DartSignal<SetLogLevel>>,
    Option<UnboundedReceiver<DartSignal<SetLogLevel>>>,
)>>;
pub static SET_LOG_LEVEL_CHANNEL: SetLogLevelCell =
    Mutex::new(None);

impl SetLogLevel {
    pub fn get_dart_signal_receiver()
        -> Result<UnboundedReceiver<DartSignal<Self>>, RinfError> 
    {       
        let mut guard = SET_LOG_LEVEL_CHANNEL
            .lock()
            .map_err(|_| RinfError::LockMessageChannel)?;
        if guard.is_none() {
            let (sender, receiver) = unbounded_channel();
            guard.replace((sender, Some(receiver)));
        }
        let (mut sender, mut receiver_option) = guard
            .take()
            .ok_or(RinfError::NoMessageChannel)?;
        // After Dart's hot restart or app reopen on mobile devices,
        // a sender from the previous run already exists
        // which is now closed.
        if sender.is_closed() {
            let receiver;
            (sender, receiver) = unbounded_channel();
            receiver_option = Some(receiver);
        }
        let receiver = receiver_option.ok_or(RinfError::MessageReceiverTaken)?;
        guard.replace((sender, None));
        Ok(receiver)
    }
}

impl ResultMsg {
    pub fn send_signal_to_dart(&self) {
        let result = send_rust_signal(
            12,
            self.encode_to_vec(),
            Vec::new(),
        );
        if let Err(error) = result {
            debug_print!("{error}\n{self:?}");
        }
    }
}

impl EventMsg {
    pub fn send_signal_to_dart(&self) {
        let result = send_rust_signal(
            13,
            self.encode_to_vec(),
            Vec::new(),
        );
        if let Err(error) = result {
            debug_print!("{error}\n{self:?}");
        }
    }
}

impl LogMsg {
    pub fn send_signal_to_dart(&self) {
        let result = send_rust_signal(
            14,
            self.encode_to_vec(),
            Vec::new(),
        );
        if let Err(error) = result {
            debug_print!("{error}\n{self:?}");
        }
    }
}
