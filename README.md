# search.sh

## Descripción
El script `search.sh` se utiliza para buscar repositorios en una plataforma (posiblemente Harness) que coincidan con un término de búsqueda proporcionado por el usuario. Los resultados son almacenados en un archivo CSV y también se imprimen en la consola.

## Requisitos previos
- Herramientas necesarias: `bash`, `jq`.

## Uso

### Sintaxis
```sh
./search.sh <HARNESS_API_KEY> <HARNESS_ACCOUNT_ID> "término de búsqueda"
```

### Parámetros
| Nombre              | Descripción                           |
|---------------------|---------------------------------------|
| HARNESS_API_KEY     | Clave de API para autenticación       |
| HARNESS_ACCOUNT_ID  | Identificador único de la cuenta      |
| término de búsqueda | El texto a buscar en los repositorios. |

## Nota para usuarios de Mac
Si estás utilizando un sistema operativo Mac, asegúrate de que la primera línea del script sea:
```sh
#!/usr/bin/env bash
```
Esto garantiza que se utilice el intérprete `bash` instalado en tu sistema.

## Flujo del Script

1. **Configuración Inicial**:
   - Se configuran las variables de entorno `HARNESS_API_KEY` y `HARNESS_ACCOUNT_ID` utilizando los argumentos proporcionados al script.
   - Se define la ruta base a los scripts utilizados y el archivo CSV para guardar resultados.

2. **Recuperación de Organizaciones**:
   - Se llama al script `org.sh` con el comando `list` para obtener una lista de organizaciones en formato JSON.
   - Los identificadores de las organizaciones se extraen y se guardan en un array.

3. **Iteración por Organizaciones**:
   - Para cada organización, se llama al script `project.sh` para listar sus proyectos.
   - Para cada proyecto, se llama al script `code.sh` con el término de búsqueda proporcionado para obtener los repositorios que coincidan.

4. **Procesamiento de Repositorios**:
   - Se convierte la respuesta JSON en un array de objetos y se itera sobre ellos.
   - Para cada repositorio encontrado, se extraen su identificador y URL de Git.
   - Si ambos valores están presentes, se guardan en el archivo CSV con la siguiente estructura: `Org,Project,Identifier,Git_URL`.

5. **Salida**:
   - Se imprime un mensaje en consola que indica cuántos repositorios fueron encontrados para cada organización y proyecto.

## Ejemplo de uso

Para buscar todos los repositorios que contengan el término "api" utilizando una clave de API específica y un identificador de cuenta, se ejecutaría:

```sh
./search.sh "pat.6a3c11de258de92cd7b2f9a4.3c11de258de92cd7b2f9.11de258de92cd7b2f9a" "de258de92cd7b2f9a46a3c11" "api"
```

## Salida esperada

### Archivo CSV
El archivo CSV se genera en un directorio llamado `search` y su nombre es basado en el término de búsqueda, reemplazando los espacios por guiones bajos. Por ejemplo, si el término de búsqueda es "api", el archivo generado será `search/api.csv`.

Ejemplo de contenido del archivo CSV:
```
Org,Project,Identifier,Git_URL
org1,project1,repo1,https://git.example.com/repo1.git
org1,project2,repo2,https://git.example.com/repo2.git
org2,project3,repo3,https://git.example.com/repo3.git
```

### Mensajes en consola
Después de la ejecución, se imprimirá en consola el número de repositorios encontrados para cada combinación de organización y proyecto. Por ejemplo:
```
Scanning - Query: api
2 repos found | ORG: org1 Project: project1
3 repos found | ORG: org1 Project: project2
1 repo found | ORG: org2 Project: project3
```

## Notas
- Asegúrate de proporcionar las claves de API y los identificadores de cuenta correctos como argumentos al script.
- El script utiliza herramientas como `jq` para procesar JSON, asegúrate de tenerlas instaladas en tu sistema.