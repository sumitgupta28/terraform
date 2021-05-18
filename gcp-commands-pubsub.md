## gcloud - pubsub

### gcloud - pubsub -- topics create

```sh
    $ gcloud pubsub topics create transaction-topic
    Created topic [projects/gcp-learning-project-312006/topics/transaction-topic].
```

### gcloud - pubsub -- topics create

```sh
    $ gcloud pubsub subscriptions create transaction-subscription --topic=transaction-topic
    Created subscription [projects/gcp-learning-project-312006/subscriptions/transaction-subscription].

    $ gcloud pubsub subscriptions create transaction-notification-subscription --topic=transaction-topic
    Created subscription [projects/gcp-learning-project-312006/subscriptions/transaction-notification-subscription].
```

### gcloud - pubsub -- topics list

```sh
    $ gcloud pubsub topics list
    ---
    labels:
    name: transaction-topic
    name: projects/gcp-learning-project-312006/topics/transaction-topic
```

### gcloud - pubsub -- subscriptions list

```sh
    $ gcloud pubsub subscriptions list
    ---
    Welcome to Cloud Shell! Type "help" to get started.
    Your Cloud Platform project in this session is set to gcp-learning-project-312006.
    Use “gcloud config set project [PROJECT_ID]” to change to a different project.
    $ gcloud pubsub topics list
    ---
    labels:
    name: transaction-topic
    name: projects/gcp-learning-project-312006/topics/transaction-topic
    $ gcloud pubsub subscriptions list
    ---
    ackDeadlineSeconds: 10
    enableMessageOrdering: true
    expirationPolicy:
    ttl: 300000.500s
    labels:
    name: transaction-notification-subscription
    messageRetentionDuration: 1200s
    name: projects/gcp-learning-project-312006/subscriptions/transaction-notification-subscription
    pushConfig: {}
    retainAckedMessages: true
    topic: projects/gcp-learning-project-312006/topics/transaction-topic
    ---
    ackDeadlineSeconds: 10
    enableMessageOrdering: true
    expirationPolicy:
    ttl: 300000.500s
    messageRetentionDuration: 1200s
    name: projects/gcp-learning-project-312006/subscriptions/transaction-subscription
    pushConfig: {}
    retainAckedMessages: true
    topic: projects/gcp-learning-project-312006/topics/transaction-topic
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


### gcloud - pubsub -- subscriptions - ack by --ack-ids

```sh

    $ gcloud pubsub topics publish test-topic --message "Test Message By Sumit"messageIds:
    - '2190636037482888'

    $ gcloud pubsub subscriptions pull test-topic-subcription
    ┌───────────────────────┬──────────────────┬──────────────┬────────────┬──────────────────┬────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
    │          DATA         │    MESSAGE_ID    │ ORDERING_KEY │ ATTRIBUTES │ DELIVERY_ATTEMPT │                                                                                               ACK_ID                                                                                               │
    ├───────────────────────┼──────────────────┼──────────────┼────────────┼──────────────────┼────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
    │ Test Message By Sumit │ 2190636037482888 │              │            │                  │ RFAGFixdRkhRNxkIaFEOT14jPzUgKEUSBAJPAihdeTFIPkFdcmhRDRlyfWByYgxAVAcXVX4KURsHaE5tdR_As6DGS0NVaFsaAQRGVX5cXB8FalRUfS_yuKvhptu3WUAvOZP76sppe8LDy8dvZiM9XhJLLD5-MD1FQV5AEkw7CERJUytDCypYEU4EISE-MD5FUw │└───────────────────────┴──────────────────┴──────────────┴────────────┴──────────────────┴────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

    $ gcloud pubsub subscriptions ack test-topic-subcription --ack-ids RFAGFixdRkhRNxkIaFEOT14jPzUgKEUSBAJPAihdeTFIPkFdcmhRDRlyfWByYgxAVAcXVX4KURsHaE5tdR_As6DGS0NVaFsaAQRGVX5cXB8FalRUfS_yuKvhptu3WUAvOZP76sppe8LDy8dvZiM9XhJLLD5-MD1FQV5AEkw7CERJUytDCypYEU4EISE-MD5FUw
    Acked the messages with the following ackIds: [RFAGFixdRkhRNxkIaFEOT14jPzUgKEUSBAJPAihdeTFIPkFdcmhRDRlyfWByYgxAVAcXVX4KURsHaE5tdR_As6DGS0NVaFsaAQRGVX5cXB8FalRUfS_yuKvhptu3WUAvOZP76sppe8LDy8dvZiM9XhJLLD5-MD1FQV5AEkw7CERJUytDCypYEU4EISE-MD5FUw]
    {}

    $ gcloud pubsub subscriptions pull test-topic-subcription
    Listed 0 items.

```


### gcloud - pubsub -- subscriptions - auto-ack with limit

```sh

$ gcloud pubsub subscriptions pull test-topic-subcription --auto-ack --limit 5
┌───────────┬──────────────────┬──────────────┬────────────┬──────────────────┐
│    DATA   │    MESSAGE_ID    │ ORDERING_KEY │ ATTRIBUTES │ DELIVERY_ATTEMPT │
├───────────┼──────────────────┼──────────────┼────────────┼──────────────────┤
│ 1-Message │ 2190661279903587 │              │            │                  │
│ 2-Message │ 2190662183186251 │              │            │                  │
│ 3-Message │ 2190679171387722 │              │            │                  │
└───────────┴──────────────────┴──────────────┴────────────┴──────────────────┘
```