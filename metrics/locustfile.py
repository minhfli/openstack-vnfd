from locust import HttpUser, task


class MyUser(HttpUser):
    host = "http://172.24.4.1"
    network_timeout = 60

    @task
    def burn_cpu(self):
        retries = 2
        while retries > 0:
            try:
                self.client.get("/cpu/burn.php", timeout=self.network_timeout)
                break
            except Exception as e:
                print(f"Request failed: {e}")
                retries -= 1
