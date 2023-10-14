package com.conference.dc23.ldn.store_launcher

import android.content.Intent
import android.os.Bundle
import android.provider.Settings
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.ripple.rememberRipple
import androidx.compose.material3.Card
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.darkColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.content.ContextCompat.startActivity

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            MaterialTheme(
                colorScheme = darkColorScheme()
            ) {
                Surface {
                    GridLauncher()
                }
            }
        }
    }
}

@Composable
fun GridLauncher() {
    val context = LocalContext.current
    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        verticalArrangement = Arrangement.SpaceBetween,
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        repeat(3) {
            Row(
                modifier = Modifier
                    .weight(1.0f)
                    .fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                AppCard(
                    "Products",
                    R.drawable.ic_launcher_foreground,
                    Modifier.weight(1.0f)
                ) {
                    startActivity(
                        context,
                        Intent("com.conference.dc23.ldn.swag_store_app.OPEN_PRODUCTS"),
                        null
                    )
                }
                AppCard(
                    "Cart",
                    R.drawable.ic_launcher_foreground,
                    Modifier.weight(1.0f)
                ) {
                    startActivity(
                        context,
                        Intent("com.conference.dc23.ldn.swag_store_app.OPEN_CART"),
                        null
                    )
                }
                AppCard(
                    "Settings",
                    R.drawable.ic_launcher_foreground,
                    Modifier.weight(1.0f)
                ) {
                    startActivity(context, Intent(Settings.ACTION_SETTINGS), null)

                }
            }
        }
    }
}

@Composable
fun AppCard(title: String, imgRes: Int, modifier: Modifier, onClick: () -> Unit) {
    Surface(
        modifier = modifier
            .padding(4.dp)
            .clip(RoundedCornerShape(16.dp)),
    ) {
        Card(
            modifier = Modifier
                .fillMaxSize()
                .clickable(
                    interactionSource = remember { MutableInteractionSource() },
                    indication = rememberRipple(
                        bounded = true,
                        color = MaterialTheme.colorScheme.primary
                    ),
                ) { onClick() }
        ) {
            Column(
                modifier = Modifier.fillMaxSize(),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center,
            ) {
                Image(
                    painter = painterResource(id = imgRes),
                    contentDescription = title,
                    contentScale = ContentScale.Fit,
                    modifier = Modifier
                        .size(48.dp)
                        .align(Alignment.CenterHorizontally)
                )
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = title,
                    style = TextStyle(
                        fontSize = 20.sp,
                        color = MaterialTheme.colorScheme.onBackground,
                    )
                )
            }
        }
    }
}
