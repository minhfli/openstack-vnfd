from locust import LoadTestShape


class StagesShape(LoadTestShape):

    stages = [
        {"duration": 15, "users": 20, "spawn_rate": 0.1},
        {"duration": 70, "users": 200, "spawn_rate": 1},
        {"duration": 45, "users": 32, "spawn_rate": 0.1},
    ]

    def tick(self):

        # get runtime in miniute
        run_time = self.get_run_time() / 60.0

        for stage in self.stages:
            if run_time < stage["duration"]:
                tick_data = (stage["users"], stage["spawn_rate"])
                return tick_data
            else:
                run_time -= stage["duration"]
        return None
