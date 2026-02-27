#import "@preview/basic-resume:0.1.3": *

// Put your personal information here, replacing mine
#let name = "Jan Troják"
#let location = "Prague, CZ"
#let email = "trojakjan24@gmail.com"
#let github = "github.com/zezav-cz"
#let phone = "+(420) 723 915 634"
#let personal-site = "zezav.cz"

#show: resume.with(
  author: name,
  location: location,
  email: email,
  github: github,
  phone: phone,
  personal-site: personal-site,
  accent-color: "#26428b",
  font: "New Computer Modern",
)

/*
* Lines that start with == are formatted into section headings
* You can use the specific formatting functions if needed
* The following formatting functions are listed below
* #edu(dates: "", degree: "", gpa: "", institution: "", location: "")
* #work(company: "", dates: "", location: "", title: "")
* #project(dates: "", name: "", role: "", url: "")
* #extracurriculars(activity: "", dates: "")
* There are also the following generic functions that don't apply any formatting
* #generic-two-by-two(top-left: "", top-right: "", bottom-left: "", bottom-right: "")
* #generic-one-by-two(left: "", right: "")
*/
== About me
My name is Jan Troják, I am a fresh graduate of the Bachelor’s programme at the Faculty of Information Technology of the Czech Technical University in Prague, and soon enough, a Matsres’s degree graduate at FIT CVUT. I have graduated from the Security and Information Technology specialization. For my Master's degree, I studied computer networks and systems, a topic I found really interesting.

Unlike application development, my passion lies in the core of IT and computer science. I am fascinated by the underlying infrastructure, from the hardware to the application running on it. This led me to infrastructure and possibly DevOps. I enjoy topics such as operating systems and networking, which are critical parts of IT infrastructure. It also allows me to see products and systems as a whole.

I would say that I am not really that much into programming of large high-level applications. I used to claim that I am not a great large-scale project programmer, but it has probably changed with the rush of AI technologies, which have shifted the focus more toward system design than programming. In programming, I enjoy low-level programming with a focus on optimization and “hacking” solutions.
== Education

#edu(
  institution: "Bachelor's branch Security and Information Technology",
  location: "Prague, CZ",
  dates: dates-helper(start-date: "Sep 2019", end-date: "Jul 2023"),
  degree: "Czech Technical University in Prague | Faculty of Information Technology",
)
- *Computer science*: \ Networking, Unix-like systems, Algorithms and data structures, SQL relational databases, Architecture of computers
- *Programming*: \ Basicis of C/C++, Basics of Python, SQL
- *Security*: \ HW security, system security, network security, ITU-T X.800, secure code
- Dean’s Award for outstanding final theses

#edu(
  institution: "Master specialization Computer Systems and Networks",
  location: "Prague, CZ",
  dates: dates-helper(start-date: "Sep 2023", end-date: "2026"),
  degree: "Czech Technical University in Prague | Faculty of Information Technology",
)
- *Computer science*: \ Combinatorial Optimization using heuristics, Grid parallel computing, Modern Networking (SDNs, MPLS…), GPU computing, Network security, Virtualization and cloud computing, Multi-core CPUs Computing, Distributed systems, Basics of nonSQL databases
- *Programming*: \ C++, Cuda, Basics of Ruby
- *Security*: \ Basics of reverse engineering

I have finished the Master's program and am waiting for the state exams and thesis evaluation.

== Projects

#project(
  role: "Owner",
  name: "Edge Operator",
  //dates: dates-helper(start-date: "Nov 2023", end-date: "Present"),
  url: "github.com/dvojak-cz/Bachelor-Thesis",
)
A Kubernetes operator, which extends the capabilities of the Kubernetes orchestrator by addressing devices in an adjacent private cluster network. Enabled communication supports TCP, UDP, and protocols from higher-level layers of the ISO/OSI model that use TCP or UDP.
#project(
  role: "Owner",
  name: "Matrix Calculator",
  //dates: dates-helper(start-date: "Nov 2023", end-date: "Present"),
  url: "github.com/dvojak-cz/MatrixCalculator",
)
Interactive application implementing a matrix calculator. The application supports matrix operations and basic linear algebra operations.
#project(
  role: "Owner",
  name: "Worker Site",
  //dates: dates-helper(start-date: "Nov 2023", end-date: "Present"),
  url: "github.com/dvojak-cz/WorkerSite",
)
Worker Site is a web application for managing work records. The application is used to record the work done. The user can manage his work records in the application; he can change, delete, and create them. The application was designed to register reports for the Solfronk company.
#project(
  role: "Owner",
  name: "Network Clock",
  //dates: dates-helper(start-date: "Nov 2023", end-date: "Present"),
  url: "github.com/dvojak-cz/NetworkClock",
)
Network Clock is a fictitious application used to store the password for generating the security code. The application sets the lowest possible runtime settings before running to minimize the impact on the system when the application is attacked. Privileged operations run in a separate process for the minimum necessary time.
// == Extracurricular Activities

// #extracurriculars(
//   activity: "Capture The Flag Competitions",
//   dates: dates-helper(start-date: "Jan 2021", end-date: "Present"),
// )
// - Founder of Les Amateurs (#link("https://amateurs.team")[amateurs.team]), currently ranked \#4 US, \#33 global on CTFTime (2023: \#4 US, \#42 global)
// - Organized AmateursCTF 2023 and 2024, with 1000+ teams solving at least one challenge and \$2000+ in cash prizes
//   - Scaled infrastructure using GCP, Digital Ocean with Kubernetes and Docker; deployed custom software on fly.io
// - Qualified for DEFCON CTF 32 and CSAW CTF 2023, two of the most prestigious cybersecurity competitions globally

== Publications
#bibliography("my-bib.bib",
  title: none,
  full: true,
  style: "nature"
)

== Work Experience

#work(
  title: "HIL systems developer | DevOps",
  location: "Jablonec nad Nisou, CZ",
  company: "cz.Micronova",
  dates: dates-helper(start-date: "2021", end-date: "2022"),
)
Micronova is a German company that develops test systems (HIL, SIL). For half a year, I worked in the Consulting and Service department, where I helped with HIL testing on the client side. Then I worked for a year in the software development department, where I was involved in HIL testing development. I worked on integrating HIL into the cloud environment. I was also part of the newly formed DevOps team.

#work(
  title: "Infrastructure Engineer",
  location: "Prague, CZ",
  company: "Recombee s.r.o.",
  dates: dates-helper(start-date: "Aug 2023", end-date: "2026"),
)
Recombee is a Czech AI company focusing on personal recommendations. Its product delivers real-time recommendations (SaaS) across various regions worldwide. I am part of the infrastructure team, where I help maintain the on-premises private cloud environment. Most of the time, I design and implement what's called new infrastructure, which is more solid, scalable, and secure than the current one. Most of the time, I was working on the project of migrating to Kubernetes. My responsibility was the installation and maintenance of a bare-metal Kubernetes cluster and all its dependencies, including private networking, security, Vault installation, and more. Most of the time, I worked with Puppet, Terraform, and cdk8s, which were the main bootstrapping tools for the solutions.



// #extracurriculars(
//   activity: "Science Olympiad Volunteering",
//   dates: "Sep 2023 --- Present"
// )
// - Volunteer and write tests for tournaments, including LA Regionals and SoCal State \@ Caltech
#pagebreak()
== Skills
- *Programming Languages*: \
#table(
  columns: 3,
  stroke: none,
  [], [Python], [I can write scripts and smaller applications. I use it for personal projects and quick scripting. Core knowledge I got from university course and the rest from self-study.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Go], [Actively learning this language and using it for personal projects. For study purpouses I use it almost all use cases to learn it properly. At the moment I use it mostly fro dagger projects.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Ruby], [Basic knowledge of Ruby, which I got from a university course and debugging tools written in it. I have used it to implement a puppet module for issuing certificates from vault.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [C/C++], [Advanced knowlade of C/C++. I have heavily used it during my studies in courses, where I got the following knowledge: c99, c++17, CUDA, OpenMP, MPI, Effective C++, and multiprocessor optimization. I love the language(s) and their optimization capabilities. At the moment I do not use them much, I would love to use them more in the future.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Others], [basics of typescript (from cdk8s), SQL (pland, recursion), c\# (used in several projects in the past)],
)
- *Technologies*: \
  Git, UNIX, SystemD, Docker, Podman, OCI, Nginx, HAProxy, Grafana, Thanos, Prometheus, AlertManager, Vault, Puppet, Puppet Bolt, Ansible, Terraform, Kubernetes, SeaweedFS, Dagger, Github, Gitlab, Jenkins, FluxCD, Helm, Icinga, PostgreSQL, Redis

- *Networking*: \
#table(
  columns: 3,
  stroke: none,
  [], [Actively], [IP, DNS, HTTP(S), Proxy, TLS, IPtables, NFTables, FirewallD, Linux configuration (routing...), Cilium],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Theoretical], [OSI model, TCP/IP stack, BGP, MPLS, SDN, VPNs, VLANs, VXLANs, VxLANs],
)

- *Security*: \
  Encryption, hashing, secure code, system security, network security, HW security, reverse engineering, Offline CA

- *DevOp and infrastructure*: \
#table(
  columns: 3,
  stroke: none,
  [], [OS], [Debian-based, RAID, LVM, ZFS],
  table.hline(stroke: 0.1pt, start: 1),
  [], [CI/CD], [Jenkins (haven't used in a while), Github Actions, Gitlab CI, Dagger (mostly used now), FluxCD],
  table.hline(stroke: 0.1pt, start: 1),
  [], [IaC], [Puppet (large code base, writing own types), Ansible (smaller projects, roles), Terraform, CDK8S],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Kubernetes], [Bare metal deployments, Pupppet bootstraping (contributor), Deep core components knowledge, Helm, Programming of operators, FluxCD, Cilium, Deep knowledge of networking, Keda]
)

- *Others*: \
#table(
  columns: 3,
  stroke: none,
  [], [Laguagesa], [English (C1), Czech (native)],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Driving licence], [AM, B1, B],
)
