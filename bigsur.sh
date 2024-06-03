Para crear una Máquina Virtual (VM) con macOS Big Sur desde la línea de comandos utilizando `virt-install`, primero necesitarás asegurarte de que tienes acceso a un archivo de instalación de macOS Big Sur y a una imagen del sistema operativo. Lamentablemente, debido a las restricciones de licencia de macOS, no puedo proporcionarte estos archivos ni guiar específicamente sobre cómo obtenerlos.

Sin embargo, puedo proporcionarte un ejemplo de cómo sería el comando para iniciar el proceso de creación de la VM con `virt-install`. Aquí tienes un ejemplo básico:

```bash
sudo virt-install \
--name macOS-Big-Sur-VM \
--ram 4096 \
--vcpus 2 \
--disk path=/ruta/a/tu/imagen/disco.qcow2,size=40 \
--cdrom /ruta/a/tu/imagen/instalacion.iso \
--os-type darwin \
--os-variant macos11.0 \
--graphics vnc \
--network network=default \
--boot uefi
```

Asegúrate de reemplazar `/ruta/a/tu/imagen/disco.qcow2` con la ubicación de tu archivo de imagen de disco y `/ruta/a/tu/imagen/instalacion.iso` con la ubicación del archivo de instalación de macOS Big Sur.

Ten en cuenta que este es solo un ejemplo básico y es posible que necesites ajustar los parámetros según tus necesidades específicas y la configuración de tu sistema. Además, asegúrate de tener los permisos adecuados para ejecutar el comando con `sudo`.