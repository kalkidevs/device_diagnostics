package com.tricker333.testing

import android.app.ActivityManager
import android.content.Context
import android.os.Bundle
import android.os.Environment
import android.os.StatFs
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.tricker333.deviceinfo/channel" // match in Flutter

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "getTotalRAM" -> {
                    val ram = getTotalRAM()
                    result.success(ram)
                }
                "getInternalStorage" -> {
                    val storage = getInternalStorage()
                    result.success(storage)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun getTotalRAM(): Long {
        val actManager = getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager
        val memoryInfo = ActivityManager.MemoryInfo()
        actManager.getMemoryInfo(memoryInfo)
        return memoryInfo.totalMem / (1024 * 1024) // in MB
    }

    private fun getInternalStorage(): Long {
        val stat = StatFs(Environment.getDataDirectory().path)
        val bytesAvailable = stat.blockSizeLong * stat.blockCountLong
        return bytesAvailable / (1024 * 1024) // in MB
    }
}