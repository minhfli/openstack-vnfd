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
locust.stats.CONSOLE_STATS_INTERVAL_SEC = 15
locust.stats.HISTORY_STATS_INTERVAL_SEC = 15
locust.stats.CSV_STATS_INTERVAL_SEC = 10
locust.stats.CURRENT_RESPONSE_TIME_PERCENTILE_WINDOW = 30


timeout = 45  # seconds, for all users

wait_time1 = constant(0)
wait_time2 = constant(0)
wait_time3 = constant(0)
wait_time4 = constant(0)
url1 = "/cpu/burn5.php"
url2 = "/cpu/burn4.php"
url3 = "/cpu/burn3.php"  # burn6
url4 = "/cpu/burn2.php"

# 120 user for vertical scaling test


class MyUser1(FastHttpUser):
    wait_time = wait_time1
    connection_timeout = timeout
    network_timeout = timeout

    @task
    def burn_cpu(self):
        self.client.get(url1)


class MyUser2(FastHttpUser):
    wait_time = wait_time2
    connection_timeout = timeout
    network_timeout = timeout

    @task
    def burn_cpu(self):
        self.client.get(url2)


class MyUser3(FastHttpUser):
    wait_time = wait_time3
    connection_timeout = timeout
    network_timeout = timeout

    @task
    def burn_cpu(self):
        self.client.get(url3)


class MyUser4(FastHttpUser):
    wait_time = wait_time4
    connection_timeout = timeout
    network_timeout = timeout

    @task
    def burn_cpu(self):
        self.client.get(url4)
