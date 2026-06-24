# search.sh

## Descripción
El script `search.sh` se utiliza para buscar repositorios en una plataforma (posiblemente Harness) que coincidan con un término de búsqueda proporcionado por el usuario. Los resultados son almacenados en un archivo CSV y también se imprimen en la consola.

## Requisitos previos
- Herramientas necesarias: `bash`, `jq`.

## Uso

### Sintaxis
```sh
./search.sh <HARNESS_API_KEY> <HARNESS_ACCOUNT_ID> "término_de_búsqueda"
```

### Parámetros
| Nombre              | Descripción                           |
|---------------------|---------------------------------------|
| HARNESS_API_KEY     | Clave de API para autenticación       |
| HARNESS_ACCOUNT_ID  | Identificador único de la cuenta      |
| término_de_búsqueda | El texto a buscar en los repositorios. |

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
./search.sh "pat.harness.token" "harness.account" "api"
```

## Salida esperada
Después de la ejecución, en `output.csv` encontrarás una lista con los siguientes campos:
- **Org**: Identificador de la organización.
- **Project**: Identificador del proyecto.
- **Identifier**: Identificador del repositorio.
- **Git_URL**: URL del repositorio Git.

Además, se imprimirá en consola el número de repositorios encontrados para cada combinación de organización y proyecto.

## Notas
- Asegúrate de proporcionar las claves de API y los identificadores de cuenta correctos como argumentos al script.
- El script utiliza herramientas como `jq` para procesar JSON, asegúrate de tenerlas instaladas en tu sistema.