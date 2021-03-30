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