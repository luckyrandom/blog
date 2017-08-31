---
title: System Design Notes
author: Chenliang Xu
date: 2017-04-05 22:45
template: post.html
---
### Numbers
The numbers are copied from [here](https://everythingisdata.wordpress.com/2009/10/17/numbers-everyone-should-know/)

```
Operation	Time (nsec)
L1 cache reference	0.5
Branch mispredict	5
L2 cache reference	7
Mutex lock/unlock	25
Main memory reference	100
Compress 1KB bytes with Zippy	3,000
Send 2K bytes over 1 Gbps network	20,000
Read 1MB sequentially from memory	250,000
Roundtrip within same datacenter	500,000
Disk seek	10,000,000
Read 1MB sequentially from disk	20,000,000
Send packet CA -> Netherlands -> CA	150,000,000
```

```
Operation	Time (nsec)
System call overhead	400
Context switch between processes	3000
fork() (statically-linked binary)	70,000
fork() (dynamically-linked binary)	160,000
```

### Shard

### Partitioning

Rout user to different server, such mit.facebook.com,
harvard.facebook.com. Or partition by the first letter of last
name. Difficult if we need info from multiple partitions.

Common in database.

### Load balancer

#### Servers

##### DNS as load balancer

Bind multiple ip to one domain name. Limited control. Hard to
implement customized logic.

#### Software

#### Hardware

Expensive!

#### SAAS

- Google cloud load balancer
- Cloudflare load balancer
- AWS Elastic Load Balancing

#### The methods of distributing

##### Divided by context

Some servers for js, some servers for images, and some servers for
restful request. Limits: still need balancer for each server group.

##### Round robin

Some request more be more expensive than the others, and some active
user may cost more resource than the others.

Session is broken, as the requests in the session might be sent to
different servers.

Make the app server stateless, and store the session info in shared
storage, such as shared disk or database.

#### Stick session

- Store key representing the associated server, which the balancer
  translate to the server id. However, it does not solve the high
  availability problem, as the failure of a server fails all the users
  on the server.

- Store session information in load balancer.

### Cache

#### Store generated result on disk

Disk is cheap, and servers such as Apache provides excellent
performance on serving static files. E.g, the static blog generator.

Not dynamic. May have to regenerate all of the files to make change.

#### MySQL query cache

#### memcached

Store cache in ram. It is not for persistent storage, and the expired
values will be deleted in events of garbage collection. The server
must work properly when the info stored in the cache is missing.

### Database

#### Rational database

The performance is not good for write heavy transaction.

Master and slave. Good for read heavy query, as the read can query
against the slave server. The write must query against the master
server. Master is still single point of failure for writing.

Master-master set up. The writing can be queried against any of the
master server.

### Topics

#### Concurrency. Do you understand threads, deadlock, and starvation? Do you know how to parallelize algorithms? Do you understand consistency and coherence?


#### Networking. Do you roughly understand IPC and TCP/IP? Do you know the difference between throughput and latency, and when each is the relevant factor?

#### Abstraction. You should understand the systems you’re building upon. Do you know roughly how an OS, file system, and database work? Do you know about the various levels of caching in a modern OS?

#### Real-World Performance. You should be familiar with the speed of everything your computer can do, including the relative performance of RAM, disk, SSD and your network.

#### Estimation. Estimation, especially in the form of a back-of-the-envelope calculation, is important because it helps you narrow down the list of possible solutions to only the ones that are feasible. Then you have only a few prototypes or micro-benchmarks to write.

#### Availability and Reliability. Are you thinking about how things can fail, especially in a distributed environment? Do know how to design a system to cope with network failures? Do you understand durability?

### Object serialization

#### Protocol buffer

Protocol buffers are Google's language-neutral, platform-neutral,
extensible mechanism for serializing structured data – think XML, but
smaller, faster, and simpler.

Protocal is described by DSL, which can be compiled to code. For java,
it generates dumb data holders, including immutable message and
builder class. It should be wrapped (adopted) to implement rich method
or to keep boundary from protocal controlled by other team.


Supported types are

 - primitive type
 - repeat type [array]
 - struct
 - enum

A value can be marked optional or required. A required will stay as
required forever, for the interest backward compatibility.

Each field is marked by tag number, to specify the storage position.

##### Schema evolution

The rule is for protocol, but the rules apply in general to schema
evolution.

- you must not change the tag numbers of any existing fields.
- you must not add or delete any required fields.
- you may delete optional or repeated fields.
- you may add new optional or repeated fields but you must use fresh
  tag numbers (i.e. tag numbers that were never used in this protocol
  buffer, not even by deleted fields).

#### gRPC

Remote Procedure Call

#### Avro


No tag is required. The compatibility of versions of avro is handled
by mapping (... not the right word) of schemas.

### Sth

 - RAID :: Cluster of disk :)

 - Active-active mode, active-passive mode

 - High availability

 - Geo redundancy

