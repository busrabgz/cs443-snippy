from locust import HttpUser, TaskSet, task


class MyTaskSet(TaskSet):

    @task
    def post_urls(self, **kwargs):
        
        headers = {'content-type': 'text/plain'}
        return self.client.post("/urls", data="http://www.google.com", headers=headers, name="/urls", **kwargs)
    
    @task
    def get_urls_id(self, **kwargs):
        object_id =  "4170157c"
        return self.client.get("/urls/{0}".format(object_id), name="/urls/{id}", **kwargs)

    @task
    def get_u_id(self, **kwargs):
        object_id =  "4170157c"
        return self.client.get("/u/{0}".format(object_id), name="/u/{id}", **kwargs)

    @task
    def get_healthcheck(self, **kwargs):
        return self.client.get("/healthcheck", name="/healthcheck", **kwargs)

    @task
    def get(self, **kwargs):
        return self.client.get("/", name="/", **kwargs)


class MyLocust(HttpUser):
    tasks = [MyTaskSet]
    min_wait = 1000
    max_wait = 3000

