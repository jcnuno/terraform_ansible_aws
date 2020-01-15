# Despliegue con terraform en aws y configuración con ansible de nginx

En este artículo vamos a introducir un ejemplo de como podemos, usando una herramienta de orquestación como Terraform, crear infraestructura en un servicios IaaS (vamos usar Amazon Web service) y posteriormente como podemos realizar una configuración automática sobre el recurso creado usando una herramienta de automatización como ansible (vamos a instalar un servidor nginx).

## Instalación de Terraform

Terraform es un software de infraestructura como código (infrastructure as code) desarrollado por HashiCorp. Permite a los usuarios definir y configurar la infraestructura en un lenguaje de alto nivel, generando un plan de ejecución para desplegarla en distintos servicios cloud (OpenStack, AWS, Azure, GCE,...).

La instalación de esta herramienta es muy sencilla, sólo tenemos que bajar un binario de la [página de descargas](https://www.terraform.io/downloads.html) y moverlo a un directorio que este en el path del sistema.

    $ wget https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip
    $ unzip terraform_0.12.19_linux_amd64.zip
    $ mv terraform /usr/local/bin
    $ terraform -v
    Terraform v0.12.19

## Configuración de terraform

Con terraform podemos programar un plan que gestione recursos en muchos servicios, en la documentación podemos encontrar los distintos [providers](https://www.terraform.io/docs/providers/index.html) con los que podemos interactuar. En nuestro caso vamos a usar el provider de [AWS](https://www.terraform.io/docs/providers/index.html), en la documentación podemos ver todas las funciones que nos ofrecen para este servicio cloud. En este ejemplo vamos a gestionar los servicio de EC2 (Elastic compute cloud), en concreto vamos a crear una instancia y le vamos a asociar una ip elástica.

### Autentificación 

Tenemos varias formas de indicar nuestras [credenciales](https://www.terraform.io/docs/providers/aws/index.html#authentication) de AWS para que terraform se pueda conectar a nuestra cuenta. Nostros vamos a elegir el uso de variables de entorno, para evitar escribir nuestras credenciales en un fichero de texto que normalmente estará guardado en un repositorio git.

Por lo tanto antes de ejecutar terraform tendremos que definir las siguiente variables de entorno:

    $ export AWS_ACCESS_KEY_ID="anaccesskey"
    $ export AWS_SECRET_ACCESS_KEY="asecretkey"
    $ export AWS_DEFAULT_REGION="us-west-2"

