from locust import HttpUser, task


class MyUser(HttpUser):
    host = "http://172.24.4.150"

    @task
    def burn_cpu(self):
        self.client.get("/cpu/burn.php")
