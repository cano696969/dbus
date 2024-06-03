#!/bin/bash

# Verificar si el script se ejecuta como root
if [ "$(id -u)" -eq 0 ]; then
  echo "No debes ser un usuario root para ejecutar este script. Por favor, ejecuta ./install.sh" >&2
  exit 1
fi

# Verificar si la virtualización está habilitada
if [ "$(grep -Ec '(vmx|svm)' /proc/cpuinfo)" -eq '0' ]; then
  echo "La virtualización no está habilitada. Si tu procesador soporta virtualización, ve a la configuración del BIOS y habilita VT-x (Virtualization Technology Extension) para procesadores Intel y AMD-V para procesadores AMD." >&2
  exit 1
fi

# Instalación actual
if command -v apt-get > /dev/null; then
  # Instalar programas necesarios
  sudo apt-get -y install qemu-kvm qemu-system-x86 qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst

  # Agregar usuario al grupo libvirt para permitir acceso a las VMs
  sudo usermod -aG libvirt "$USER"
  sudo usermod -aG kvm "$USER"
fi

# Instalar frontend de gestión de VMs basado en configuraciones del sistema
if command -v apt-get > /dev/null; then # Instalar virt-manager
  sudo apt-get install -y virt-manager
fi

# Habilitar el servicio libvirtd usando systemd si está disponible
if command -v systemctl > /dev/null; then
  sudo systemctl enable --now libvirtd
fi

# Verificar si el servicio libvirtd se habilitó correctamente
if [ "$(systemctl status libvirtd.service | awk 'NR==2{print $4}')" != "enabled;" ]; then
  echo "El servicio libvirtd no está habilitado. Por favor, verifica por qué." >&2
fi

# Iniciar la red predeterminada para la conexión de red
sudo virsh net-start default
sudo virsh net-autostart default
if [ "$(sudo virsh net-list --all | awk 'NR==3{print $3}')" != "yes" ]; then 
  echo "La red predeterminada para las máquinas virtuales no está configurada para iniciarse automáticamente. Por favor, verifica por qué." >&2
fi

# Fin
echo "Reinicia el sistema."
