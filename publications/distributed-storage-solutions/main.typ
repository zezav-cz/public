#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "Distributed block and object storage",
  authors: (
      (
      name: "Jan Troják",
      department: "Faculty of Information Technology",
      institution: "Czech technical university in Prague",
      email: "trojaj12@cvut.cz",
      location: "Prague, Czechia",
    ),
  ),
  abstract: [
    This document explores the evolution and categorization of storage solutions, focusing on the shift from traditional systems to modern distributed storage architectures. It highlights key types of storage—block storage, file systems, and object storage—and their respective use cases, advantages, and challenges. The need for distributed storage is addressed through scalability, fault tolerance, and performance considerations, with emphasis on architectural concepts like storage pools, replication, erasure coding, and scalability strategies. The paper also provides an overview of practical implementations, offering insights into the design and functionality of modern storage systems.
  ],
  bibliography: bibliography("refs.bib"),
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

= Storages solutions
Storage systems are continuously evolving from simply designed systems that meet basic criteria to new, modern ones intended to satisfy the new needs of the modern computing era. Those solutions can be categorized into three main solutions (block storage, file-systems, and object storage), each providing and serving different needs with its abstraction layer.
== Block storage
Block storage has been part of computers and servers since its beginnings. It provides an abstraction layer for different physical storage systems, such as hard drives, solid-state drives, storage networks, etc. This abstraction allowed for a split of a physical implementation of the underlying storage solution and a logical understanding of the provided storage. In implication, this offers an easy communication interface between storage architects who deal with low-level solutions and infrastructure/application architects who use that storage for their needs.

Block storage devices transform their storage layer into virtual blocks of bits. Those blocks are usually referenced by linear addressing so applications can use precise parts of the devices. This allows almost complete access to logical storage provided by the low-level architecture. This type of access does not limit applications or users, and the user of the block device is expected to be able to manage and organize data on the underlying storage.

Direct use of block storage is often used for IO performance-sensitive applications or use cases when no other structure is needed.

Databases like Oracle, Aerospike, and many others use direct access to block storage devices. This allows those systems to manage their data structures directly. This can lead to memory access operations optimization by correctly serializing data onto the storage, implementing an on-device cache#sym.dots.h @oracle_2025 @aerospike_2024 

Direct access to block storage often comes with the cost of complex implementation and the need for a deep understanding of low-level concepts. Even though concretely designed storage for specific use cases can lead to storage access optimization, it can be expensive and time-consuming. Also, when not done right, it can lead to inefficiency compared to using some known abstractions. That's why using other abstraction layers that provide much more user-friendly APIs and don't require a deep understanding of low-level concepts is common.

Block storage is often used as a base abstraction for different usages. The most commonly known usage is file systems, another layer of abstraction that provides the familiar directory/file structure that most people are familiar with. Another usage could be directly implementing storage systems like object storage. Both these types will be discussed later in the document. 

== File systems
The most common and well-known storage abstraction is a file system. This kind of abstraction uses files and folders to structure data. Data are stored in files (units of data) and then organized in folders, which can nest one in the other. Files can be addressed by specifying a path (sorted list of nested folders and file name at the end). It’s commonly used on personal computers, and even though the idea is kind of complex, it's well-understood by people. 

This abstraction allows users to view data as distinct files rather than as raw chunks of bits. Users don’t need to worry about addresses, sizes, or where to store their data physically. They interact with files, while the underlying file system implementation handles the complexities of data storage seamlessly. Thanks to files and folders, it is much easier to perform operations such as backups, replication… which can be done at the file/folder level.

Another nice feature is that files and folders can hold its metadata, which can be used for things such as ACL#sym.dots.h

It may seem that abstracting storage into files and folders is a clever idea and optimal solution, but such a solution also has some drawbacks as well. The first drawback is the loss of performance when accessing files. Since files are identified using a path (folders and files), accessing those underlying systems has to go through various structures to get to the data locations. A widespread implementation of the file system is _ext4_. This type of file system uses _inoes_ that point to data blocks. This means that each folder in which the file is stored results in a search in one data structure and referencing another block of data on a block device. This is overhead that is present when navigating over file-systems. Reading data stored in a file system is also complicated and consists of multiple parts. @muzikář_žďárek_2021 File-systems are primarily designed for people, so they can use such nice abstractions. 

The second drawback is linked to sharing data among different systems, traditional filesystems were designed to be used on isolated systems. They are tightly coupled with FS implementation, which makes them hard to share. This tightly coupled property also force systems to serialize all operations with FS using locks, which can cause performance problems when used in a shared meaner.@jialin_2018
== Object storage
Object storage uses _objects_ as its core data structure, similarly objects hold data and metadata as files in file-systems. Unlike files which are organized in hierarchical structures (folders), objects are arranged in a flat structure. Objects are all sored in a set and no relation/hierarchy is present. While some implementations emulate hierarchy with slashes in object names, the underlying system remains flat. This structure eliminates the performance overhead associated with traversing complex directory paths. Additionally, unlike file systems, object storage imposes no strict limitations on metadata, allowing each object to store extensive and flexible metadata, which can include attributes like ACLs.#footnote[File-systems as a abstraction also does not limit metadata in any way, but majority of implementation does.@muzikář_žďárek_2021]

Whereas file systems rely on tightly coupled implementations to manage data, object storage employs an "object store" to manage and organize access to data blocks. The object store is a loosely coupled layer, making it ideal for distributed environments. This loose coupling also removes the need for locking mechanisms common in POSIX-based file systems, enabling higher scalability and concurrency.@jialin_2018

Another distinguishing feature of object storage is its interface. Instead of local file system protocols, object storage is accessed via network-based APIs or protocols, with Amazon's S3 being the most well-known example. This web-based approach decouples object storage from specific operating systems, simplifying integration across distributed systems.

Object storage is intended to provide a highly scalable, durable, and performant solution compared to traditional file and block storage. However, it has its challenges. The non-POSIX interface can complicate development, and there may be performance trade-offs related to indexing and managing objects. Despite these limitations, object storage offers a compelling alternative for modern data storage needs.

#v(1.5em) #line(stroke: 0.5pt)
Both _file system_ and _object storage_ has its pros and cons. File systems are well know, fast and nice solution for nodes, that does not need any concurrent access to underling storage. On the other hand object storages are much simple and thanks to the loosely coupled API they are more suitable for concurrent access, applications usage and remote storage access.

= Need for distributed storage solutions
Storage and its needs have existed since the beginning of the computation era. However, with the rapid evolution of computer science and its use in the real world, new challenges and needs have emerged for storage layers.

Modern computing environments face significant challenges in managing the ever-growing volume of data. Traditional storage solutions often struggle to keep up with the demands of scalability, fault tolerance, and high performance required by contemporary applications. The rise of cloud computing has amplified these challenges, as dynamic workloads and distributed applications demand storage solutions that can adapt and scale efficiently. Another part of computation that introduces new challenges for storage systems is grid computing, where parallel access to storage systems is needed.

The concept of distributed storage solutions has emerged to address these solutions. Distributed storage solution can represent various solutions or their combination. To clarify those solution, here is list of them with explanation:

- `Parallel file/object write` \ Traditional file-systems and object stores does not allow parallel writing to same file resp. object at a same time. When two subjects want ta access data at a same time, they need to synchronize they access. This can be problem in HPC, when data are usually anourous and computation power is time limited. Distributed storage solutions address this by enabling parallel writes to a different data nodes in a cluster.
- `Replicated storage` \ Replicated storage ensures data redundancy by storing multiple copies of the same data across different nodes in a distributed system. This enhances data reliability and availability. If one node fails, the system can seamlessly access data from another replica. Replication can be synchronous (immediate replication to all nodes) or asynchronous (updates occur after a delay). Common use cases include disaster recovery, fault tolerance, and read-intensive workloads where replicas distribute the read load.
- `Remote storage` \ Remote storage allows data to be stored on a different physical or virtual location and accessed over a network. It decouples storage from compute resources, enabling greater flexibility in resource allocation. Network protocols such as NFS (Network File System) or iSCSI (Internet Small Computer Systems Interface) facilitate access to remote storage. This approach is often used in cloud environments and distributed systems where centralized data storage is necessary.
- `Remote storage pools` \ Remote storage pools aggregate multiple remote storage resources into a single logical pool. This abstraction allows users to manage and utilize storage more efficiently without worrying about the underlying physical location of the data. Storage pools can span multiple nodes, data centers, or even cloud regions, offering seamless scalability, load balancing, and high availability. This is particularly useful in hybrid and multi-cloud setups.

#v(1.5em) #line(stroke: 0.5pt)
In next chapters, we will mainly discuse Remote storage pools. When addressing distributed storage, please conciser solution that can serve Remote storage pools. We will focus on scalability of thouse storages, theyr replication, fault tolerance, performance and API they they can offer to users.

= Distributed storage solution architecture
To address the scalability of storage, we need the ability to scale both resources and clients effectively. Scaling can be achieved in two primary ways: horizontally and vertically.
- `Vertical scaling` \ Vertical scaling involves upgrading the capacity or performance of a single storage node (e.g., adding more disks). While this method can provide significant performance improvements and scale the storage, it becomes much harder to maintain such node and also can introduce a point of failure. @vondra_2022b
- `Horizontal scaling` \ Horizontal scaling involves adding more storage nodes to a pool, distributing the storage workload across these nodes. This approach is much easier to administer at scale and provides flexibility in accommodating both resource and client growth. It also enables dynamic scaling without disrupting ongoing operations. @vondra_2022b

Distributed storage solutions usually use both types of scaling. Both approaches have pros and cons—one offers unlimited scaling, and the other offers scaling without any performance loss. In the following chapters, we will talk about storage pools. Through storage pools, we will address a set of available storage on a set of pools. By _vertical scaling_, we will understand the extension of any storage on any node already present in the pool. By _horizontal scaling_, we will understand adding a new node to the pool.

== Architecture of distributed solutions
Remote storage pools, hyper-converged infrastructure, and software-defined storage are highly related terms. Software-defined storages often use terms like control, data, and management plane. Let's discuss those. It will give an abstract overview of how storages are implemented (distributed included) and also introduce new terms that can be later used.

Storage abstractions (like file systems) have two distinguished responsibilities. One of those is storing bits on an underlying block device; this operation requires communication with the API that block storage offers. This kind of operation can be imagined as "write data `A` to place `K`". The second operation is actually organizing the data to available storage; this kind of operation serializes the user's data to the underlying address abstractions of block devices. Organizing operations can be imagined as "Where should I put metadata for this picture?" This operation is completely different from the first one. Both rely on each other but perform different types of logic. @moucha_2021 @kohli_2022

In any storage solution implementation, isolating those two logics into separate components makes perfect sense. The component that cares about actual information storage is called the _data plan_, and the part that determines the structure of the data is called the _control plane_. The last term used in storage solution implementations is the _management plane_. The management plane is usually some high-level API that can communicate with the control plane and ask it to perform operations with data. All those planes communicate with each other with defined API interfaces and creates scalable software solution.#footnote[This terminology is actually coming from the networking world. Its heavily linked with designing of software-defined networking.] Such communication between those layers is captured in @sds from _SDC2022_ conference where Jaspal Kohli was giving speech about Architecture of Scale-out Block Storage. @kohli_2022

#figure(
  image("images/architecture_of_distributed_solutions.png", width: 80%),
  caption: [A curious figure. @kohli_2022],
) <sds>

This kind of separation of responsibilities allows us to think about storage in separate roles, where logic is separated from actual physical drives. This allows operator to treat nodes in a storage pool only, just like a data plane, and control those data from other components that do not have to be even part of the pools. This separation is a key concept of building distributed storage solutions. 

The above abstraction is used mainly for meeting the scalability requirements of distributed storage systems. Another often-mentioned requirement is high availability and fault tolerance. This requirement is usually solved by using replication or erasure coding.

=== DRBD
Distributed Replicated Storage System (DRBD) is an open-source solution for block replication over the network between multiple Linux storage nodes. _Linbit_ developed it, now drbd is  one of the most common solutions for block replication across Linux servers. Although there are other solutions, DRBD is one of the most used. It is mentioned here as a concrete implementation.

DRBD is implemented as a kernel module in a Linux kernel. It enables reliable replication (RAID 1) for Linux nodes across a network. This replication is often used to meet requirements on fault tolerance and high availability systems. Thanks to the replication, when all nodes but one are unavailable, the remaining one can still offer a fail-over and serve its purpose. This replication comes with a network usage cost and more storage space consumption from the storage pool. @linbit_2025

Even though drbd it self does not implement a distributed storage system (storage pool based) it's often used as a part of solutions to those systems as you will see in #ref(<impl>, supplement: "Chapter")

=== Erasure code
Another approach that is used to solve high availability and fault tolerant of data is a principle called erasure coding.

Erasure coding is a principle that allows data to be fault-tolerant even without a direct replica. The main idea behind erasure coding is to split data into several chunks and distribute them across different nodes in a storage pool. To offer fault tolerance, additional data (e.g., parity or redundant pieces of data) are provided to chunks to guarantee that data are still recoverable and readable even when some node in a poll crashes. @purestorage_2025

This method is much more space-efficient than replication since it does not have to store full replication data. The disadvantage of this approach is a performance cost when data is being restored or written since erasure codes need to be recalculated. @purestorage_2025

= Implementations of distributed storage solutions <impl>
In this chapter, concrete implementation of strategic solutions will be introduced. Selected technologies are all open source and selected based on popularity. 

== Ceph
One of the most commonly used scale-out storage systems is a ceph. It was created as a dissertation project by Sage Weila at the University of California. Now it's maintained by large corporations like RedHead. @vondra_2022c It is used as software-defined storage in 75% of installations of Openstack (2024), and it is also a popular solution for persistence in Kubernetes systems. @openstack_2025 It provides all three mentioned abstractions (FileSystem, Object storage, Block storage). This time of storages can be access via various of API such as S3, iSCSI, NFS, CSI #sym.dots.h

Ceph storage is based on the RADOS system and CRUSH algorithm.
RADOS (Reliable Autonomous Distributed Object Store) is a simple and scalable object store that can work with objects of various sizes. Ceph website mentions that its abstraction layer allows Ceph to build robust storage solutions on top of that. @foundation_2009 

An atomic unit that RADOS operates with is just a simple object that is identified by a unique ID. Those objects can vary in size and are completely isolated from others. Object storage collects those objects into pools, which are collections of objects with similar storage properties. These properties usually define how objects are meant to be stored (number of replications, geolocation #sym.dots.h). OSD (object store daemons) are used as a data plane in a Ceph solution. Daemon is just a process on a system that can store data. The collection of OSD forms a storage cluster that can be used to store any number of pools. This is a basic abstraction that ceph uses to store data. All operations that allow administrators to control pools and objects are controlled via RADOS interfaces. @foundation_2009

Specified abstraction only discusses how data (objects) are threaded in the system; it does not say anything about how data are supposed to be distributed among servers. CRUSH does.

CRUSH (Controlled Replication Under Scalable Hashing) is a deterministic algorithm used in Ceph to manage data placement efficiently across distributed storage clusters. It eliminates the need for a centralized metadata service by calculating data placement dynamically since it can computer the exact location of that deterministically on each node. CRUSH works based on a CRUSH map, which defines the storage cluster's topology, including hierarchical relationships (e.g., devices, hosts, racks) and failure domains (e.g., zones, racks, hosts). When CRUS is provided with an object and CRUSH map, it can compute the exact location of data in a cluster. @vondra_2022c @gaurav_2019 This makes the ceph system fully distributed and easy to scale.

CRUSH together with RADOS interface makes the ceph solution highly horizontally scalable and distributed solution. Ceph contains many other parts to serve distributed storages, but CRUSH and RADOS are considered as a hard of the ceph infrastructure. Other components like metrics server, metadata components are only small, but still important peaces to make cep infrastructure complete. 

This type of architecture makes Ceph fully horizontally scalable. When all infrastructure requirements, like networking, are met, it can offer linear scalability, which makes it one of the most robust open-source solutions. It is also suitable for concurrent access to data blocks since those are spread across multiple nodes. 

To map its architecture, we can consider the OSD daemons to serve a data plane responsibility and the CRUSH algorithm to play a role in the control plane. Ceph supports both of the mentioned strategies for fault tolerance (Erasure coding and replication).

== LinStore
Linstore is a distributed storage solution that offers only block storage. It's maintained by the same company as DRBD (_Linode_) and is often called an orchestrator for DRBD. It's also commonly used as a data layer for Kubernetes clusters as a ceph solution.

Linstore's architecture is much simpler than Ceph's. It provides a layer on top of DRBD that manages where to store data in a pool of nodes. It consists of two main components: satellite service, which represents the data plane layer; and controller, which serves as the control plane.

Satellites are services running on each node that work with available storage on its node. Linstore is designed to support two types of underlying storage. The two supported technologies are LVM and ZFS. Satellites interact with those technologies to allocate data in the pool and store data there. The allocation of those allocated resources is replicated using DRBD.

Controller services that play the role of the control plane in the store are often (highly available) replicated services, which provide API to users, orchestrate storage, and communicate with satellites to interact with storage resources. For each block requested, the controller chooses the master node in the pool, where data will be stored. Because of this architecture, the requested block size is limited by the maximal size of available storage on a node in the pool. This makes it seem like a crucial limitation for the storage system, but since block devices are usually the base backbone of storage systems, it's okay for most of the use cases.

The above-specified architecture makes the system efficient for single access (not concurrent) because data are readable from a single node. It also makes the system fault-tolerant since data can be restored from underlying physical storage even when all in-store components are corrupted.

Overall, Linstore is considered a robust enterprise solution for creating distributed data pool solutions. 

== Longhorn
Longhorn is another software-defined solution that offers a storage pool. It's meant to be used only in the Kubernetes environment and has a similar architecture as a Linstore. It operates completely in userspace, which makes it less coupled to kernel versions. @anderson_2024 It is much simpler than the previous two, and that's it's easy to maintain. Because of its simplicity, it does offer some limitations (number of replications, block size limited to smallest disk size in cluster #sym.dots.h). Another downside of Longhorn is its high CPU usage. @simplyblock_2024 Because of those limitations, it's suitable only for mid-size storage solutions. @longhorn_2019

== Swift
Swift is an eventually consistent, highly available, distributed object store primarily used in OpenStack environments. It was designed to handle large-scale, unstructured data while ensuring durability and availability across a distributed cluster. Swift’s architecture is built around a proxy-based design where API requests are processed by proxy servers, which determine the data location and route requests accordingly. The location of data is based on ring computations, which serve as the core mapping mechanism between logical object identifiers and their physical storage locations. This mapping is called rings since it's based on modulo arithmetics. Rings provide a control plane in a Swift. This mapping is computed from multiple data structures that define placement policies for accounts, containers, and objects separately. It can distribute data based on policies, fail domains, and other parameters. @flament_2014 Those ring policies are mapped to containers.

Container is a abstraction, that groups objects with same properties (policies). Containers are managed by container servers, which are responsible of listing objects, in specific containers. Those lists are stored and replicated between instances in SQLite DB. Metadata about objects are stored directly on underling FS using Extended attributes (xattrs).

Swift can work on an already existing file system or use raw block devices as its storage. 

Swift objects can be accessed either using Swift rest API or well-known S3 API. @swift_2019 Even though Swift can serve as fault tolerance, horizontal scabble, and highly available storage, it's not as robust as other mentioned solutions. Still, it can serve as a good enough S3 solution. @swift_2019

== CubeFS
CubeFS is a fairly new distributed storage system designed for high-performance data management with support for object storage, file systems, and block storage. Currently, the project is in the incubating stage of CNCF and has become the popular solution for new infrastructures. It provides a scalable and resilient architecture by sharding data and metadata across multiple nodes while maintaining high availability and consistency through Raft-based replication mechanisms. CubeFS is commonly used in Kubernetes environments but can also be deployed outside of containerized infrastructures.

As a control plane, CubeFS uses Master nodes responsible for managing data and metadata shards (creating, deleting, updating, and checking consistency). The master node service can be deployed in a highly available setup with raft leader election. Its state is persisted in RocksDB, which is replicated.

Another core component is the metadata subsystem, distributed across multiple Metadata Nodes. Metadata nodes share and replicate data using the Multi-Raft replication protocol. Each metadata node maintains two B-Tree structures for storing inodes, which are kept in memory for high-speed access. For disaster recovery of metadata nodes, CubeFS also logs metadata changes to disk and periodically takes snapshots, ensuring data can be restored even in case of failure.

For data storage, Data Nodes handle actual file contents and support Erasure Coding to optimize storage efficiency and fault tolerance. CubeFS also introduces NormalExtent, a mechanism for handling large files (≥ 4TiB), which allows efficient storage and retrieval of massive datasets. @cubefs_2025

This solution can provide S3, HDFS, and Posix API for accessing data via its Object Gateway subsystem. This should enable easy integration into various environments.

Combining sharded metadata management, Erasure Coding, and Multi-Raft replication makes CubeFS a highly scalable and reliable solution for distributed storage needs. Although CubeFS is still a new, evolving technology, it can now serve as a distributed software-defined storage solution.  @cubefs_2025

#pagebreak()
