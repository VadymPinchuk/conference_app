package com.conference.dc23.ldn.swag_store_app

class CartActivity : BaseActivity() {

    override var entryPoint = "storeCart"

    override fun getDartEntrypointArgs() = listOf("cart")
}
