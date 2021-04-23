# Snippy.me: URL Shortener
<!--
***yukardaki svgleri değiş
-->

http://www.snippy.me

Feel free to edit this document.

## About

Snippy.me is a CS443 Cloud Computing project for shortening URLs.

[Design Report(https://github.com/busrabgz/cs443-snippy/blob/a60a94ed59f45002b9fbfe27aff99a08290fc15e/CS443%20Design%20Report.pdf)]



## Project Structure

- `core/` - Contains core microservice source code and deployment files.
- `analytics/` - Contains analytics microservice source code and deployment files.
- `libs/` - Contains shared models and functions used by both microservices.
- `snippy_ui/` - Contains flutter source code.
- `flutter_api/` - Contains auto-generated dart api connectors to the backend.
- `redis_config/` - Contains redis config and deployment files.
- `scripts/` - Contains handy scripts to speed up deployment process.
- `docker-compose.yml` - Contains local development stack configuration.

## Project Setup

1. Clone the repository using the command: 
`git clone https://github.com/busrabgz/cs443-snippy.git`

2. Request the google-auth key from the firebase console and put it under `.d.env/key.json`

3. Install docker and docker-compose.

4. Install Flutter 2.0.4.

5. Install OpenJDK11m set PATH and JAVA_HOME (Optional, recommended for autocomplete)

6. Install Google Cloud SDK (Optional, required for deployment)

### Running
You can run the API using
```bash 
docker-compose up
```

If you want to run the local firestore emulator suit (e.g. for testing)
```bash
docker-compose up -f docker-compose.yml -f emulated.yml up
```

You can run the flutter project by importing it into VSCode or Android Studio.

If you have changed the API and you want to access those endpoints from flutter run the following command to auto generate the API client for your local development:

```bash
cd flutter_api
./generate.sh local
```

Or if you want to use the deployed API on the live server snippy.me:
```bash
./generate.sh
```

### Deploying

Make sure you have setup Google Cloud SDK. You should setup the project-id and region of the project based on your GKE cluster location.

1. Run project at least once using `docker-compose` and test whether `/healthcheck` endpoint is working. By doing this you ensure that the jars are generated before deploying.

2. Go to `scripts` folder. Modify `image_update.sh` if you want to change the version. Run `./image_update.sh` to build and upload the images to the Google Cloud Registry.

3. If no clusters are running, create one. If a cluster is running and there are deployments / services running, delete those. The services for this project can be deleted using `./delete.sh`.

4. Upload your authentication key to the GCP services.

5. Deploy using `./apply.sh`.

6. (Optional) Deploy ingress using the command `kubectl apply -f ingress.yaml` on the project root.

If you want to modify the kubernetes deployment files those are the paths where the files are stored:

- `core/deployment/[deployment|service|autoscale].yaml`: Contains Deployment, LoadBalancer and HorizontalPodAutoscaler config files for the core microservice.
- `analytics/[deployment/deployment|service|autoscale].yaml`: Contains Deployment, LoadBalancer and HorizontalPodAutoscaler config files for the analytics microservice.
- `redis_config/redis_[deployment|service].yaml`: Contains Deployment and LoadBalancer for the redis microservice.
- `ingress.yaml`: Ingress file for hostname resolution and load balancing.
