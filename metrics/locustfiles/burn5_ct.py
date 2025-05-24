from locust import FastHttpUser, task
import locust.stats
from locust import constant_throughput, constant_pacing, constant, between
import time

# run with locust

# for stats csv
locust.stats.PERCENTILES_TO_REPORT = [
    0.25,
    0.50,
    0.65,
    0.75,
    0.80,
    0.90,
    0.95,
    0.99,
    1.00,
]
# for UI
locust.stats.PERCENTILES_TO_CHART = [0.25, 0.50, 0.75, 0.95, 0.99]
locust.stats.PERCENTILES_TO_STATISTICS = [0.25, 0.50, 0.75, 0.95, 0.99]


timeout = 30  # seconds, for all users


class UserBurn5_constant_throughput(  # 10^5 sqrt per request
    FastHttpUser
):  # user will request at most 1 time per second
    wait_time = constant_throughput(1)  # 1 request per second

    connection_timeout = timeout
    network_timeout = timeout

    @task
    def burn_cpu(self):
        self.client.get("/cpu/burn5.php")
