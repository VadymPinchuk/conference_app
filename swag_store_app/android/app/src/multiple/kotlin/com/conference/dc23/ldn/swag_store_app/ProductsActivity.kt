package com.conference.dc23.ldn.swag_store_app

class ProductsActivity : BaseActivity() {

    override var entryPoint = "storeProducts"

    override fun getDartEntrypointArgs() = listOf("products")
}
