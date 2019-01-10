#!/bin/bash
DownloadVirtIOISO() {
    aria2c -x -c -o /var/lib/vz/template/iso/virtio-win.iso https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/stable-virtio/virtio-win.iso
}