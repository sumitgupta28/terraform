

### gcloud components list

```
    C:\>gcloud components list

    Your current Cloud SDK version is: 333.0.0
    The latest available version is: 333.0.0

    +------------------------------------------------------------------------------------------------------------+
    |                                                 Components                                                 |
    +---------------+------------------------------------------------------+--------------------------+----------+
    |     Status    |                         Name                         |            ID            |   Size   |
    +---------------+------------------------------------------------------+--------------------------+----------+
    | Not Installed | App Engine Go Extensions                             | app-engine-go            |  4.8 MiB |
    | Not Installed | Appctl                                               | appctl                   | 18.7 MiB |
    | Not Installed | Cloud Bigtable Command Line Tool                     | cbt                      |  7.5 MiB |
    | Not Installed | Cloud Bigtable Emulator                              | bigtable                 |  6.4 MiB |
    | Not Installed | Cloud Datalab Command Line Tool                      | datalab                  |  < 1 MiB |
    | Not Installed | Cloud Datastore Emulator                             | cloud-datastore-emulator | 18.4 MiB |
    | Not Installed | Cloud Firestore Emulator                             | cloud-firestore-emulator | 41.6 MiB |
    | Not Installed | Cloud Pub/Sub Emulator                               | pubsub-emulator          | 60.4 MiB |
    | Not Installed | Cloud SQL Proxy                                      | cloud_sql_proxy          |  7.2 MiB |
    | Not Installed | Emulator Reverse Proxy                               | emulator-reverse-proxy   | 14.5 MiB |
    | Not Installed | Google Container Registry's Docker credential helper | docker-credential-gcr    |  1.8 MiB |
    | Not Installed | Kustomize                                            | kustomize                | 23.1 MiB |
    | Not Installed | Minikube                                             | minikube                 | 24.2 MiB |
    | Not Installed | Nomos CLI                                            | nomos                    | 20.1 MiB |
    | Not Installed | Skaffold                                             | skaffold                 | 16.1 MiB |
    | Not Installed | anthos-auth                                          | anthos-auth              | 16.4 MiB |
    | Not Installed | config-connector                                     | config-connector         | 43.6 MiB |
    | Not Installed | gcloud Alpha Commands                                | alpha                    |  < 1 MiB |
    | Not Installed | gcloud app Java Extensions                           | app-engine-java          | 53.1 MiB |
    | Not Installed | gcloud app PHP Extensions                            | app-engine-php           | 19.1 MiB |
    | Not Installed | gcloud app Python Extensions                         | app-engine-python        |  6.1 MiB |
    | Not Installed | gcloud app Python Extensions (Extra Libraries)       | app-engine-python-extras | 27.1 MiB |
    | Not Installed | kpt                                                  | kpt                      | 12.7 MiB |
    | Not Installed | kubectl                                              | kubectl                  |  < 1 MiB |
    | Not Installed | kubectl-oidc                                         | kubectl-oidc             | 16.4 MiB |
    | Not Installed | pkg                                                  | pkg                      |          |
    | Installed     | BigQuery Command Line Tool                           | bq                       |  < 1 MiB |
    | Installed     | Cloud SDK Core Libraries                             | core                     | 17.7 MiB |
    | Installed     | Cloud Storage Command Line Tool                      | gsutil                   |  3.9 MiB |
    | Installed     | gcloud Beta Commands                                 | beta                     |  < 1 MiB |
    +---------------+------------------------------------------------------+--------------------------+----------+
    To install or remove components at your current SDK version [333.0.0], run:
    $ gcloud components install COMPONENT_ID
    $ gcloud components remove COMPONENT_ID

    To update your SDK installation to the latest version [333.0.0], run:
    $ gcloud components update
```



## gcloud - compute  


## gcloud - pubsub

### gcloud - pubsub -- topics create

```sh
    $ gcloud pubsub topics create transaction-topic
    Created topic [projects/weighty-wonder-308406/topics/transaction-topic].
```

### gcloud - pubsub -- topics create

```sh
    $ gcloud pubsub subscriptions create transaction-subscription --topic=transaction-topic
    Created subscription [projects/weighty-wonder-308406/subscriptions/transaction-subscription].

    $ gcloud pubsub subscriptions create transaction-notification-subscription --topic=transaction-topic
    Created subscription [projects/weighty-wonder-308406/subscriptions/transaction-notification-subscription].
```

### gcloud - pubsub -- topics list

```sh
    $ gcloud pubsub topics list
    ---
    labels:
    name: transaction-topic
    name: projects/weighty-wonder-308406/topics/transaction-topic
```

### gcloud - pubsub -- subscriptions list

```sh
    $ gcloud pubsub subscriptions list
    ---
    Welcome to Cloud Shell! Type "help" to get started.
    Your Cloud Platform project in this session is set to weighty-wonder-308406.
    Use “gcloud config set project [PROJECT_ID]” to change to a different project.
    $ gcloud pubsub topics list
    ---
    labels:
    name: transaction-topic
    name: projects/weighty-wonder-308406/topics/transaction-topic
    $ gcloud pubsub subscriptions list
    ---
    ackDeadlineSeconds: 10
    enableMessageOrdering: true
    expirationPolicy:
    ttl: 300000.500s
    labels:
    name: transaction-notification-subscription
    messageRetentionDuration: 1200s
    name: projects/weighty-wonder-308406/subscriptions/transaction-notification-subscription
    pushConfig: {}
    retainAckedMessages: true
    topic: projects/weighty-wonder-308406/topics/transaction-topic
    ---
    ackDeadlineSeconds: 10
    enableMessageOrdering: true
    expirationPolicy:
    ttl: 300000.500s
    messageRetentionDuration: 1200s
    name: projects/weighty-wonder-308406/subscriptions/transaction-subscription
    pushConfig: {}
    retainAckedMessages: true
    topic: projects/weighty-wonder-308406/topics/transaction-topic
```

### gcloud - pubsub -- topics publish

```sh

    $ gcloud pubsub topics publish transaction-topic --message="Hello World"                                                                    
                            
    messageIds:
    - '2132247786660374'

```


### gcloud - pubsub -- subscriptions pull

```sh

    $ gcloud pubsub subscriptions pull transaction-notification-subscription --auto-ack
    ┌──────────────────────────────────┬──────────────────┬──────────────┬────────────┬──────────────────┐
    │               DATA               │    MESSAGE_ID    │ ORDERING_KEY │ ATTRIBUTES │ DELIVERY_ATTEMPT │
    ├──────────────────────────────────┼──────────────────┼──────────────┼────────────┼──────────────────┤
    │ Hello World                      │ 2132247786660374 │              │            │                  │
    └──────────────────────────────────┴──────────────────┴──────────────┴────────────┴──────────────────┘
    
    $ gcloud pubsub subscriptions pull transaction-subscription --auto-ack                                                                                           
                            
    ┌──────────────────────────────────┬──────────────────┬──────────────┬────────────┬──────────────────┐
    │               DATA               │    MESSAGE_ID    │ ORDERING_KEY │ ATTRIBUTES │ DELIVERY_ATTEMPT │
    ├──────────────────────────────────┼──────────────────┼──────────────┼────────────┼──────────────────┤
    │ Hello World                      │ 2132247786660374 │              │            │                  │
    └──────────────────────────────────┴──────────────────┴──────────────┴────────────┴──────────────────┘
```