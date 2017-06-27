
task = Task.create!(
                    name: "Get groceries",
                    description: "Buy more fruits",
                    priority: 7,
                    deadline: 2.days.from_now,
                    complete: false,
                    duration: 60,
                    favorite: true
                    )