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
Infrastructure engineer and IT enthusiast with a focus on security, Linux administration, networking, and distributed systems. I hold a Bachelor’s degree in Security and Information Technology and have completed the Master’s programme in Computer Systems and Networks, both at the Faculty of Information Technology at the Czech Technical University in Prague.

Unlike application development, my passion lies in the core of IT and computer science. I am fascinated by the underlying infrastructure, from the hardware to the application running on it. This led me to infrastructure and possibly DevOps. I enjoy topics such as operating systems and networking, which are critical parts of IT infrastructure. It also allows me to see products and systems as a whole.

I would say that I am not really that much into programming of large high-level applications. I used to claim that I am not a great large-scale project programmer, but it has probably changed with the rush of AI technologies, which have shifted the focus more toward system design than programming. In programming, I enjoy low-level programming with a focus on optimization and “hacking” solutions.
== Education

#block(breakable: false)[
  #edu(
    institution: "Bachelor’s branch Security and Information Technology",
    location: "Prague, CZ",
    dates: dates-helper(start-date: "Sep 2019", end-date: "Jul 2023"),
    degree: "Czech Technical University in Prague | Faculty of Information Technology",
  )
  - *Computer science*: \ Networking, Unix-like systems, Algorithms and data structures, SQL relational databases, Architecture of computers
  - *Programming*: \ Basics of C/C++, Basics of Python, SQL
  - *Security*: \ HW security, system security, network security, ITU-T X.800, secure code
  - Dean’s Award for outstanding final theses
]

#block(breakable: false)[
  #edu(
    institution: "Master specialization Computer Systems and Networks",
    location: "Prague, CZ",
    dates: dates-helper(start-date: "Sep 2023", end-date: "2026"),
    degree: "Czech Technical University in Prague | Faculty of Information Technology",
  )
  - *Computer science*: \ Combinatorial Optimization using heuristics, Grid parallel computing, Modern Networking (SDNs, MPLS…), GPU computing, Network security, Virtualization and cloud computing, Multi-core CPUs Computing, Distributed systems, Basics of nonSQL databases
  - *Programming*: \ C++, Cuda, Basics of Ruby
  - *Security*: \ Basics of reverse engineering

  I have finished the Master’s program and am waiting for the state exams and thesis evaluation.
]

=== Additional
- Attendant of #link("https://www.prumyslovkaliberec.cz/pro-uchazece/soboty-s-technikou")[Soboty s technikou] (Střední průmyslová škola v Liberci) - 2015
- Represented school at physics and math competitions at the Liberec region level

== Projects

#block(breakable: false)[
  #project(
    role: "Owner",
    name: "Edge Operator",
    url: "github.com/dvojak-cz/Bachelor-Thesis",
  )
  A Kubernetes operator, which extends the capabilities of the Kubernetes orchestrator by addressing devices in an adjacent private cluster network. Enabled communication supports TCP, UDP, and protocols from higher-level layers of the ISO/OSI model that use TCP or UDP.
]
#block(breakable: false)[
  #project(
    role: "Owner",
    name: "Matrix Calculator",
    url: "github.com/dvojak-cz/MatrixCalculator",
  )
  Interactive application implementing a matrix calculator. The application supports matrix operations and basic linear algebra operations.
]
#block(breakable: false)[
  #project(
    role: "Owner",
    name: "Worker Site",
    url: "github.com/dvojak-cz/WorkerSite",
  )
  Worker Site is a web application for managing work records. The application is used to record the work done. The user can manage his work records in the application; he can change, delete, and create them. The application was designed to register reports for the Solfronk company.
]
#block(breakable: false)[
  #project(
    role: "Owner",
    name: "Network Clock",
    url: "github.com/dvojak-cz/NetworkClock",
  )
  Network Clock is a fictitious application used to store the password for generating the security code. The application sets the lowest possible runtime settings before running to minimize the impact on the system when the application is attacked. Privileged operations run in a separate process for the minimum necessary time.
]
#block(breakable: false)[
  #project(
    role: "Owner",
    name: "Personal Cloud Infrastructure",
    url: "zezav.cz",
  )
  In my free time, I develop and maintain my own cloud infrastructure. It currently consists of a small number of virtual machines hosted at a cloud provider with a peer-to-peer CDN. I use it to host static content, personal services, monitoring, a game server, and a VPN. It serves as a playground for testing and learning new technologies.
]
#block(breakable: false)[
  #project(
    role: "Contributor",
    name: "puppet-k8s",
    url: "github.com/voxpupuli/puppet-k8s",
  )
  Contributor and feature developer to an open-source Puppet module for installing Kubernetes clusters on arbitrary servers, including bare metal.
]
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

#block(breakable: false)[
  #work(
    title: "HIL Commissioning Technician (external contractor)",
    location: "Mladá Boleslav, CZ",
    company: "cz.Micronova",
    dates: dates-helper(start-date: "2017", end-date: "2020"),
  )
  Commissioning and testing HIL systems on-site for customers as an external service provider. This was my first engineering job, where I learned the basics of HIL testing and electrical engineering. This role served as a bridge from primarily hardware-oriented work to software development of HIL components.
]

#block(breakable: false)[
  #work(
    title: "HIL systems developer | DevOps",
    location: "Jablonec nad Nisou, CZ",
    company: "cz.Micronova",
    dates: dates-helper(start-date: "2021", end-date: "2022"),
  )
  Micronova is a German company that develops test systems (HIL, SIL). For half a year, I worked in the Consulting and Service department, where I helped with HIL testing on the client side. Then I worked for a year in the software development department, where I was involved in HIL testing development. I worked on integrating HIL into the cloud environment. I was also part of the newly formed DevOps team.
]

#block(breakable: false)[
  #work(
    title: "Infrastructure Engineer",
    location: "Prague, CZ",
    company: "Recombee s.r.o.",
    dates: dates-helper(start-date: "Aug 2023", end-date: "2026"),
  )
  Recombee is a Czech AI company focusing on personal recommendations. Its product delivers real-time recommendations (SaaS) across various regions worldwide. Part of the infrastructure team, helping maintain the on-premises private cloud environment. Primary focus on designing and implementing the new infrastructure, which is more solid, scalable, and secure than the current one. Key responsibility was the migration to Kubernetes, including installation and maintenance of a bare-metal Kubernetes cluster and all its dependencies — private networking, security, Vault installation, and more. Main tools used: Puppet, Terraform, and cdk8s.
]

#block(breakable: false)[
  #work(
    title: "Web Administrator",
  )
  Running and maintaining a small number of websites for relatives, friends, and former employers free of charge.
]

// #extracurriculars(
//   activity: "Science Olympiad Volunteering",
//   dates: "Sep 2023 --- Present"
// )
// - Volunteer and write tests for tournaments, including LA Regionals and SoCal State \@ Caltech
== Skills
- *Programming Languages*: \
#table(
  columns: 3,
  stroke: none,
  [], [Python], [Scripts and smaller applications. Used for personal projects and quick scripting. Core knowledge from a university course, the rest from self-study.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Go], [Actively learning and using for personal projects. Used for almost all study purposes to learn it properly. Currently used mostly for Dagger projects.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Ruby], [Basic knowledge from a university course and debugging tools written in it. Used to implement a Puppet module for issuing certificates from Vault.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [C/C++], [Advanced knowledge of C/C++. Heavily used during studies: C99, C++17, CUDA, OpenMP, MPI, Effective C++, and multiprocessor optimization. Strong appreciation for the optimization capabilities of these languages.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Others], [Basics of TypeScript (from cdk8s), SQL (plans, recursion), C\# (used in several projects in the past)],
)
- *Technologies*: \
  Git, UNIX, SystemD, Docker, Podman, OCI, Nginx, HAProxy, Grafana, Thanos, Prometheus, AlertManager, Vault, Puppet, Puppet Bolt, Ansible, Terraform, Kubernetes, SeaweedFS, Dagger, Github, Gitlab, Jenkins, FluxCD, Helm, Icinga, PostgreSQL, Redis

- *Networking*: \
#table(
  columns: 3,
  stroke: none,
  [], [Actively], [IP, DNS, HTTP(S), Proxy, TLS, IPtables, NFTables, FirewallD, Linux configuration (routing...), Cilium],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Theoretical], [OSI model, TCP/IP stack, BGP, MPLS, SDN, VPNs, VLANs, VXLANs],
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
  [], [Kubernetes], [Bare metal deployments, Puppet bootstrapping (contributor), Deep core components knowledge, Helm, Programming of operators, FluxCD, Cilium, Deep knowledge of networking, Keda]
)

- *Others*: \
#table(
  columns: 3,
  stroke: none,
  [], [Languages], [English (C1), Czech (native)],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Driving licence], [AM, B1, B],
)
