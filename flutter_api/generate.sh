echo "Deleting old api folders."
rm -r snippy_core_api snippy_analytics_api
mkdir snippy_core_api
mkdir snippy_analytics_api

if [ "$1" = "local" ]
then
    CORE_BASE=localhost:8089
    ANALYTICS_BASE=localhost:8082
else
    CORE_BASE=snippy.me
    ANALYTICS_BASE=analytics.snippy.me
fi

wget $CORE_BASE/v3/api-docs.yaml -O core_api.yaml
wget $ANALYTICS_BASE/v3/api-docs.yaml -O analytics_api.yaml

if [ "$1" = "local" ]
then
    sed -i 's/localhost/10.0.2.2/g' core_api.yaml
    sed -i 's/localhost/10.0.2.2/g' analytics_api.yaml
fi

java -jar openapi-generator-cli.jar generate -i core_api.yaml -g dart -c core.yaml --enable-post-process-file -o snippy_core_api

java -jar openapi-generator-cli.jar generate -i analytics_api.yaml -g dart -c analytics.yaml --enable-post-process-file -o snippy_analytics_api

pushd snippy_core_api
flutter pub get

pushd ../snippy_analytics_api
flutter pub get

pushd ..
rm core_api.yaml analytics_api.yaml
