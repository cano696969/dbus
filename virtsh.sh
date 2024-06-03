Para activar la virtualización y configurar un hipervisor en Debian, sigue estos pasos detallados:

### 1. Verificar Soporte de Virtualización en la BIOS

Antes de configurar cualquier cosa en el sistema operativo, asegúrate de que la virtualización esté habilitada en la BIOS/UEFI de tu máquina.

- Reinicia tu computadora y entra en la BIOS/UEFI (generalmente presionando una tecla como `Del`, `F2`, `F10`, `Esc` durante el arranque).
- Busca una opción relacionada con la virtualización. Esto puede estar etiquetado como `Intel VT-x`, `AMD-V`, `Virtualization Technology`, o algo similar.
- Habilita esta opción y guarda los cambios, luego reinicia tu computadora.

### 2. Instalar los Paquetes Necesarios

Instala QEMU, KVM y Virt-Manager. Esto te permitirá configurar y gestionar máquinas virtuales.

```bash
sudo apt update
sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system virt-manager bridge-utils
```

### 3. Verificar y Activar los Servicios de Virtualización

1. **Verifica que KVM esté instalado correctamente:**

   ```bash
   sudo kvm-ok
   ```

   Si ves un mensaje como "KVM acceleration can be used", entonces todo está bien.

2. **Asegúrate de que el servicio libvirt está corriendo:**

   ```bash
   sudo systemctl enable libvirtd
   sudo systemctl start libvirtd
   sudo systemctl status libvirtd
   ```

### 4. Agregar tu Usuario a los Grupos Necesarios

Para poder usar QEMU/KVM sin permisos de superusuario, añade tu usuario a los grupos `libvirt` y `kvm`:

```bash
sudo usermod -aG libvirt $(whoami)
sudo usermod -aG kvm $(whoami)
```

Cierra sesión y vuelve a iniciar sesión para que los cambios surtan efecto.

### 5. Verificar la Instalación

1. **Verifica que los dispositivos de virtualización estén disponibles:**

   ```bash
   lsmod | grep kvm
   ```

   Deberías ver algo como `kvm_intel` o `kvm_amd` dependiendo de tu CPU.

2. **Verifica que libvirt esté corriendo correctamente:**

   ```bash
   virsh list --all
   ```

   Esto debería listar las máquinas virtuales gestionadas por libvirt (aunque al principio puede que no haya ninguna).

### 6. Configurar Virt-Manager

1. **Inicia Virt-Manager:**

   ```bash
   virt-manager
   ```

2. **Configura tu primera máquina virtual:**

   - Abre Virt-Manager.
   - Clic en "File" y luego "New Virtual Machine".
   - Sigue el asistente para crear y configurar tu máquina virtual.

### 7. Crear una Máquina Virtual desde la Línea de Comandos

Si prefieres la línea de comandos, puedes usar `virt-install` para crear una máquina virtual. Aquí hay un ejemplo de cómo crear una VM básica:

```bash
sudo virt-install \
--name=MiVM \
--vcpus=2 \
--memory=2048 \
--cdrom=/ruta/a/tu/iso/debian.iso \
--disk size=20 \
--os-variant=debian10 \
--network bridge=virbr0
```

Este comando creará una máquina virtual con 2 CPUs, 2 GB de RAM, un disco de 20 GB, y usará una ISO de Debian para la instalación.

### 8. Gestionar Máquinas Virtuales

Puedes usar `virsh` para gestionar tus máquinas virtuales desde la línea de comandos. Algunos comandos útiles son:

- **Listar máquinas virtuales:**

  ```bash
  virsh list --all
  ```

- **Iniciar una máquina virtual:**

  ```bash
  virsh start MiVM
  ```

- **Apagar una máquina virtual:**

  ```bash
  virsh shutdown MiVM
  ```

- **Eliminar una máquina virtual:**

  ```bash
  virsh undefine MiVM
  ```

Siguiendo estos pasos, deberías tener una configuración básica de virtualización con QEMU/KVM y Virt-Manager en Debian.