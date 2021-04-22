from locust import HttpUser, TaskSet, task


class MyTaskSet(TaskSet):
    @task
    def post_urls(self, **kwargs):
        return self.client.post("/urls", name="/urls", **kwargs)

    @task
    def post_namedUrls(self, **kwargs):
        return self.client.post("/namedUrls", name="/namedUrls", **kwargs)

    @task
    def get_userUrls(self, **kwargs):
        return self.client.get("/userUrls", name="/userUrls", **kwargs)

    @task
    def get_urls_id(self, object_id, **kwargs):
        return self.client.get("/urls/{0}".format(object_id), name="/urls/{id}", **kwargs)

    @task
    def get_u_id(self, object_id, **kwargs):
        return self.client.get("/u/{0}".format(object_id), name="/u/{id}", **kwargs)

    @task
    def get_logs_id(self, object_id, **kwargs):
        return self.client.get("/logs/{0}".format(object_id), name="/logs/{id}", **kwargs)

    @task
    def get_hello(self, **kwargs):
        return self.client.get("/hello", name="/hello", **kwargs)

    @task
    def get_healthcheck(self, **kwargs):
        return self.client.get("/healthcheck", name="/healthcheck", **kwargs)

    @task
    def get_collections(self, **kwargs):
        return self.client.get("/collections", name="/collections", **kwargs)

    @task
    def get(self, **kwargs):
        return self.client.get("/", name="/", **kwargs)


class MyLocust(HttpUser):
    tasks = [MyTaskSet]
    min_wait = 1000
    max_wait = 3000

