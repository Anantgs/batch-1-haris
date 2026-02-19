File Systems (Container Images and Layers)
• Container Images:
    ◦ Container images are fundamentally a set of files and directories that make up the userland or regular software that runs inside a container.
    ◦ They are often very similar to a regular Linux system's file structure and are used to describe the installed state of a system.
    ◦ Images make it easy to start multiple copies of the same software, which is why they are popular in virtualization and container contexts.

• Layers and Copy-on-Write (CoW):
    ◦ One of the "fancy" aspects of container images is the concept of layers, which are a mechanism for composing together files and directories.
    ◦ These layers are merged to create a unified view, providing a foundation for inheritance (e.g., basing an application image on an official Debian image).
    ◦ Layers provide a copy-on-write (CoW) view of the files. When a file is modified, it's copied to the topmost writable layer, hiding the original lower layer file. Deletion is handled similarly by creating a special "whiteout" marker in the upper layer.

• Union File Systems:
    ◦ Layers are typically implemented using union file systems (like OverlayFS), which provide a merged view of multiple directories.
    ◦ Using a union file system helps in making minor changes efficiently (by adding a new layer with just the changes instead of copying the whole image) and starting new containers more quickly (by adding a new empty layer on top for each container's writable space without duplicating the whole image).
    ◦ OverlayFS is a union file system built into Linux and is Docker's default storage driver. It merges two or more directories (upperdir and lowerdir) to form a union.

• Docker's Storage and Layers:
    ◦ Docker stores its image metadata and layers in /var/lib/docker/overlay2 when using the overlay2 driver.
    ◦ When a container is created from an image, Docker creates new directories for it within this storage. One directory contains customized settings for the container (e.g., hostname, DNS settings) (often with an init suffix), and another is where the container can write its own data; this latter directory ultimately serves as the upperdir for the OverlayFS mount of the container's root file system.
    ◦ The lowerdir in the OverlayFS mount references the underlying image layers, often using short symlinks to reduce path length.