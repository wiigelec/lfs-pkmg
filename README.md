  
`lfs-pkmg` is a package build and management solution for Linux From Scratch (LFS) and Beyond Linux From Scratch (BLFS). This tool is an extension of the LFS educational philosophy, designed for users who have already completed a successful build of LFS. It is intended to help you learn what it takes to build and maintain a Linux distribution, rather than simply serve as a shortcut for building packages.

### **lfs-pkmg: Linux From Scratch Package Management**

lfs-pkmg is a package build and management solution designed to simplify the process of creating a Linux From Scratch (LFS) and Beyond Linux From Scratch (BLFS) system. It automates the typically manual and time-consuming steps of building a system from source code.

#### **Key Features**

* **Two Modes of Operation**: The tool supports a **manual mode** for granular, step-by-step control and an **auto mode** for streamlined, single-command execution.  
* **Dynamic Builds**: It dynamically generates build scripts and a Makefile from the official LFS and BLFS book XML files, ensuring that the instructions are always up-to-date.  
* **Dependency Resolution**: The tool automatically resolves package dependencies by processing the book's XML content and builds packages in the correct order.  
* **Package Management**: It includes functionality for creating portable package archives (.txz) and managing their installation, removal, and upgrading.

#### **Available Workflows**

* **Build**: For building LFS, BLFS, bootstrap, or patch packages.  
* **List**: For creating, installing, removing, or upgrading packages from a list.  
* **Package**: For managing individual packages (install, remove, upgrade).  
* **Audit**: For assessing the integrity of installed packages and system files.

**Required Dependencies**
wget
sudo
git
libxml2
libxslt
DocBook
docbook-xsl
postlfs-config-profile
lynx

See the [GETSTARTED.md](./GETSTARTED.md) for a crash course in using LPM.
