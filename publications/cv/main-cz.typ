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
== O mně
Infrastrukturní inženýr a IT nadšenec se zaměřením na bezpečnost, správu Linuxu, počítačové sítě a distribuované systémy. Jsem absolventem bakalářského oboru Bezpečnost a informační technologie a dokončil jsem magisterský program Počítačové systémy a sítě, obojí na Fakultě informačních technologií ČVUT v Praze.

Na rozdíl od vývoje aplikací mě více zajímá jádro IT a informatiky. Fascinuje mě základní infrastruktura, od hardwaru po aplikace, které na něm běží. To mě přivedlo k infrastruktuře a možná i k DevOps. Baví mě témata jako operační systémy a sítě, které jsou klíčovými součástmi IT infrastruktury. Také mi to umožňuje vidět produkty a systémy jako celek.

Řekl bych, že mě programování velkých aplikací na vysoké úrovni příliš nezajímá. Dříve jsem tvrdil, že nejsem dobrý programátor velkých projektů, ale to se pravděpodobně změnilo s nástupem technologií umělé inteligence, které posunuly důraz spíše na návrh systémů než na programování. V programování mě baví programování na nízké úrovni se zaměřením na optimalizaci a „hackerská“ řešení.

== Vzdělání
#block(breakable: false)[
  #edu(
    institution: "Bakalářská specializace Informační bezpečnost",
    location: "Praha, CZ",
    dates: dates-helper(start-date: "09 2019", end-date: "07 2023"),
    degree: "České vysoké učení technické v Praze | Fakulta informačních technologií",
  )
  - *Informatika*: \ Sítě, systémy typu Unix, algoritmy a datové struktury, relační databáze SQL, architektura počítačů
  - *Programování*: \ Základy C/C++, základy Pythonu, SQL
  - *Bezpečnost*: \ Bezpečnost hardwaru, bezpečnost systémů, bezpečnost sítí, ITU-T X.800, bezpečný kód
  - Cena děkana za vynikající závěrečné práce
]

#block(breakable: false)[
  #edu(
    institution: "Magisterská specializace Počítačové systémy a sítě",
    location: "Praha, CZ",
    dates: dates-helper(start-date: "09 2023", end-date: "2026"),
    degree: "České vysoké učení technické v Praze | Fakulta informačních technologií",
  )
  - *Informatika*: \ Kombinatorická optimalizace pomocí heuristiky, paralelní výpočty v gridové síti, moderní sítě (SDN, MPLS…), výpočty na GPU, bezpečnost sítí, virtualizace a cloud computing, výpočty na vícejádrových procesorech, distribuované systémy, základy databází nonSQL
  - *Programování*: \ C++, Cuda, základy Ruby
  - *Bezpečnost*: \ Základy reverzního inženýrství

  Dokončil jsem magisterský program a čekám na státní zkoušky a hodnocení diplomové práce.
]

=== Další
- Účastník #link("https://www.prumyslovkaliberec.cz/pro-uchazece/soboty-s-technikou")[Sobot s technikou] (Střední průmyslová škola v Liberci) - 2015
- Reprezentace školy v soutěžích z fyziky a matematiky na úrovni Libereckého kraje

== Projects

#block(breakable: false)[
  #project(
    role: "Autor",
    name: "Edge Operator",
    url: "github.com/dvojak-cz/Bachelor-Thesis",
  )
  Operátor Kubernetes, který rozšiřuje možnosti orchestrátoru Kubernetes tím, že adresuje zařízení v sousední soukromé klastrové síti. Umožněná komunikace podporuje protokoly TCP, UDP a protokoly z vyšších vrstev modelu ISO/OSI, které používají TCP nebo UDP.
]
#block(breakable: false)[
  #project(
    role: "Autor",
    name: "Matrix Calculator",
    url: "github.com/dvojak-cz/MatrixCalculator",
  )
  Interaktivní aplikace implementující maticový kalkulátor. Aplikace podporuje maticové operace a základní operace lineární algebry.
]
#block(breakable: false)[
  #project(
    role: "Autor",
    name: "Worker Site",
    url: "github.com/dvojak-cz/WorkerSite",
  )
  Worker Site je webová aplikace pro správu pracovních záznamů. Aplikace slouží k zaznamenávání vykonané práce. Uživatel může v aplikaci spravovat své pracovní záznamy, měnit je, mazat a vytvářet nové. Aplikace byla navržena pro registraci zpráv pro společnost Solfronk.
]
#block(breakable: false)[
  #project(
    role: "Autor",
    name: "Network Clock",
    url: "github.com/dvojak-cz/NetworkClock",
  )
  Network Clock je fiktivní aplikace sloužící k ukládání hesla pro generování bezpečnostního kódu. Aplikace před spuštěním nastaví nejnižší možná nastavení běhu, aby se minimalizoval dopad na systém v případě útoku na aplikaci. Privilegované operace běží v samostatném procesu po minimální nezbytnou dobu.
]
#block(breakable: false)[
  #project(
    role: "Autor",
    name: "Osobní cloudová infrastruktura",
    url: "zezav.cz",
  )
  Ve volném čase vyvíjím a spravuji vlastní cloudovou infrastrukturu. V současné době se skládá z menšího počtu virtuálních strojů hostovaných u cloudového poskytovatele s peer-to-peer CDN. Používám ji k hostování statického obsahu, osobních služeb, monitoringu, herního serveru a VPN. Slouží mi jako prostředí pro testování a učení se novým technologiím.
]
#block(breakable: false)[
  #project(
    role: "Přispěvatel",
    name: "puppet-k8s",
    url: "github.com/voxpupuli/puppet-k8s",
  )
  Přispěvatel a vývojář funkcí open-source Puppet modulu pro instalaci Kubernetes clusterů na libovolné servery, včetně bare metalu.
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

== Publikace
#bibliography("my-bib.bib",
  title: none,
  full: true,
  style: "nature"
)

== Pracovní zkušenosti

#block(breakable: false)[
  #work(
    title: "Technik kompletačního testování HIL (externí dodavatel)",
    location: "Mladá Boleslav, CZ",
    company: "cz.Micronova",
    dates: dates-helper(start-date: "2017", end-date: "2020"),
  )
  Kompletační testování HIL systémů u zákazníků jako externí dodavatel. Toto byla moje první inženýrská pozice, kde jsem se naučil základy HIL testování a elektrotechniky. Tato role sloužila jako přechod od převážně hardwarově orientované práce k vývoji softwaru HIL komponent.
]

#block(breakable: false)[
  #work(
    title: "HIL systémový vývojář | DevOps",
    location: "Jablonec nad Nisou, CZ",
    company: "cz.Micronova",
    dates: dates-helper(start-date: "2021", end-date: "2022"),
  )
  Micronova je německá společnost, která vyvíjí testovací systémy (HIL, SIL). Půl roku jsem pracoval v oddělení poradenství a služeb, kde jsem pomáhal s testováním HIL na straně klienta. Poté jsem rok pracoval v oddělení vývoje softwaru, kde jsem se podílel na vývoji testování HIL. Pracoval jsem na integraci HIL do cloudového prostředí. Byl jsem také součástí nově vytvořeného týmu DevOps.
]

#block(breakable: false)[
  #work(
    title: "Infrastructure Engineer",
    location: "Prague, CZ",
    company: "Recombee s.r.o.",
    dates: dates-helper(start-date: "08 2023", end-date: "2026"),
  )
  Recombee je česká společnost zabývající se umělou inteligencí, která se zaměřuje na osobní doporučení. Její produkt poskytuje doporučení v reálném čase (SaaS) v různých regionech po celém světě. Součást infrastrukturního týmu, pomoc s údržbou lokálního privátního cloudového prostředí. Hlavní zaměření na návrh a implementaci nové infrastruktury, která je robustnější, škálovatelnější a bezpečnější než ta současná. Klíčovou odpovědností byla migrace na Kubernetes, včetně instalace a údržby clusteru Kubernetes typu bare-metal a všech jeho závislostí — privátní síť, zabezpečení, instalace Vaultu a další. Hlavní nástroje: Puppet, Terraform a cdk8s.
]

#block(breakable: false)[
  #work(
    title: "Správa webových stránek",
  )
  Provoz a údržba menšího počtu webových stránek pro příbuzné, přátele a bývalé zaměstnavatele zdarma.
]

// #extracurriculars(
//   activity: "Science Olympiad Volunteering",
//   dates: "Sep 2023 --- Present"
// )
// - Volunteer and write tests for tournaments, including LA Regionals and SoCal State \@ Caltech
== Dovednosti
- *Programovací jazyky*: \
#table(
  columns: 3,
  stroke: none,
  [], [Python], [Skripty a menší aplikace. Používán pro osobní projekty a rychlé skriptování. Základní znalosti z univerzity, zbytek ze samostudia.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Go], [Aktivně studovaný jazyk, používaný pro osobní projekty. Pro studijní účely využíván téměř ve všech případech. V současné době používán hlavně pro projekty Dagger.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Ruby], [Základní znalosti z univerzitního kurzu a ladění nástrojů napsaných v tomto jazyce. Využito k implementaci Puppet modulu pro vydávání certifikátů z Vaultu.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [C/C++], [Pokročilé znalosti C/C++. Intenzivně využíváno během studia: C99, C++17, CUDA, OpenMP, MPI, Effective C++, optimalizace multiprocesorů. Silné ocenění optimalizačních schopností těchto jazyků.],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Ostatní], [Základy TypeScriptu (z cdk8s), SQL (plány, rekurze), C\# (použito v několika projektech v minulosti)],
)
- *Technologie*: \
  Git, UNIX, SystemD, Docker, Podman, OCI, Nginx, HAProxy, Grafana, Thanos, Prometheus, AlertManager, Vault, Puppet, Puppet Bolt, Ansible, Terraform, Kubernetes, SeaweedFS, Dagger, Github, Gitlab, Jenkins, FluxCD, Helm, Icinga, PostgreSQL, Redis

- *Sítě*: \
#table(
  columns: 3,
  stroke: none,
  [], [Aktivně], [IP, DNS, HTTP(S), Proxy, TLS, IPtables, NFTables, FirewallD, konfigurace Linuxu (směrování...), Cilium],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Teoreticky], [OSI model, TCP/IP stack, BGP, MPLS, SDN, VPNs, VLANs, VXLANs],
)

- *Bezpečnost*: \
  Šifrování, hashování, zabezpečený kód, zabezpečení systému, zabezpečení sítě, zabezpečení hardwaru, reverzní inženýrství, offline certifikační autorita

- *DevOp a infrastruktura*: \
#table(
  columns: 3,
  stroke: none,
  [], [OS], [Debian-based, RAID, LVM, ZFS],
  table.hline(stroke: 0.1pt, start: 1),
  [], [CI/CD], [Jenkins (delší dobu nepoužíváno), Github Actions, Gitlab CI, Dagger (nyní nejčastěji), FluxCD],
  table.hline(stroke: 0.1pt, start: 1),
  [], [IaC], [Puppet (velká kódová základna, psaní vlastních typů), Ansible (menší projekty, role), Terraform, CDK8S],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Kubernetes], [Nasazení na fyzickém hardwaru, Puppet bootstraping (přispěvatel), Hluboké znalosti základních komponent, Helm, Programování operátorů, FluxCD, Cilium, Hluboké znalosti sítí, Keda]
)

- *Ostatní*: \
#table(
  columns: 3,
  stroke: none,
  [], [Jazyky], [angličtina (C1), čeština (mateřský jazyk)],
  table.hline(stroke: 0.1pt, start: 1),
  [], [Řidičský průkaz], [AM, B1, B],
)
