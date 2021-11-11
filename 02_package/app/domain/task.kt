package app.domain


enum class TaskStatus {
    PENDING,
    DOING,
    DONE,
}


class Task constructor(title: String) {
    var status: TaskStatus = TaskStatus.PENDING
        private set
    var title: String = title
        private set

    override fun toString(): String {
        return "${this.title} - ${this.status}"
    }
}