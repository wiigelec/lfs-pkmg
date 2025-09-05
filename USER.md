

### **USER.md**

### **User Guide for lfs-pkmg**

This guide provides step-by-step instructions for using lfs-pkmg in manual mode, which offers fine-grained control over each step of the build and management process.

#### **Building an LFS System**

The LFS build process requires a sequence of make targets to be run in order.

1. make git-lfs: Clones or updates the LFS Git repository.  
2. make select-action-params (BUILD, LFS, REV, BRANCH, INSTALLROOT): This launches a menu to configure the build with your choice of REV (init system, e.g., sysv or systemd) and the LFS book BRANCH.  
3. make git-jhalfs: Clones or updates the jhalfs Git repository.  
4. make setup-lfs-jhalfs: Sets up the jhalfs build environment.  
5. make setup-lfs-difflog: Prepares the environment for file change tracking.  
6. make build-lfs: Runs the jhalfs tool to execute the build process.  
7. make setup-lfs-chroot: Sets up the chroot environment.  
8. make build-lfs-chroot-scripts: Runs custom scripts inside the chroot.  
9. make build-lfs-chroot-archives: Creates the final .txz package archives.

#### **Building a BLFS Package**

The BLFS build also involves a series of sequential make targets.

1. make git-blfs: Clones or updates the BLFS Git repository.  
2. make select-action-params (BUILD, BLFS, REV, BRANCH): Configures the build.  
3. make book-blfs-fullxml, book-blfs-pkglist, book-blfs-deps, book-blfs-scripts: These targets process the BLFS book's XML to create scripts, package lists, and dependency files.  
4. make select-blfs-packages: A menu appears for you to select the packages to build.  
5. make book-blfs-trees: Creates a dependency tree based on your selections.  
6. make setup-blfs-work: Initializes the build directory and creates a new Makefile.  
7. make build-blfs-work: Executes the build process.  
8. make build-blfs-archives: Creates the final .txz archives for the built packages.

#### **Managing Packages with Lists**

Package lists allow you to install, remove, or upgrade groups of packages.

* **Package List Format**: A list file contains entries in the format \[package\_name\]--\[version\]--\[architecture\]--\[build\_type\]-\[book\_version\]-\[rev\].\[compression\].  
* **Specifying Locations**: When you use targets like install-list, you select the repository (REPOPATH) and the list file (LISTPATH) from a menu, rather than entering them on the command line.

#### **Utility and Clean Targets**

These targets are for general maintenance and cleanup.

* make clean-config: Removes configuration files.  
* make clean-current: Removes the current build directory.  
* make clean-la: Deletes all .la files from standard library locations.  
* make nuke: Recursively removes the entire build directory.