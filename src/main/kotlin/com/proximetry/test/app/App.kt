package com.proximetry.test.app

import spark.Spark.get
import spark.Spark.port

class App {
    val greeting: String
        get() {
            return "Hello world."
        }
}

fun main(args: Array<String>) {
    port(19999)

    get("/hello") { _, _ ->
        App().greeting
    }
}
