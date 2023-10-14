package com.conference.dc23.ldn.swag_store_app

import io.flutter.embedding.android.FlutterActivity

abstract class BaseActivity : FlutterActivity() {

    abstract var entryPoint: String

    override fun getDartEntrypointFunctionName() = entryPoint
}
