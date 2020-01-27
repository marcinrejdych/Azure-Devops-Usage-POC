package com.proximetry.test.app

import org.slf4j.Logger
import org.slf4j.LoggerFactory
import spark.Spark.get
import spark.Spark.port

class App {
    companion object {
        val log: Logger = LoggerFactory.getLogger(App::class.java)
    }

    val greeting: String
        get() {
            val msg = Lib.generateMessage()
            log.info("Generated message: $msg")
            return msg
        }
}

fun main(args: Array<String>) {
    port(19999)

    get("/hello") { _, _ ->
        App().greeting

    }
}
