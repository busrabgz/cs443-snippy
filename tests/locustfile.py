from locust import HttpUser, TaskSet, task
import random

ids = 'face gog'.split(' ')

class MyTaskSet(TaskSet):

    @task
    def get_urls_id(self, **kwargs):
        object_id =  random.choice(ids)
        return self.client.get("/urls/{0}".format(object_id), name="/urls/{id}", **kwargs)

#    @task
#    def get_u_id(self, **kwargs):
#        object_id =  random.choice(ids)
#        return self.client.get("/u/{0}".format(object_id), name="/u/{id}", **kwargs)

    @task
    def get(self, **kwargs):
        return self.client.get("/", name="/", **kwargs)


class MyLocust(HttpUser):
    tasks = [MyTaskSet]
    min_wait = 1000
    max_wait = 3000
