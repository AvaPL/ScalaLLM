import $ivy.`dev.scalapy::scalapy-core:0.5.3`

import me.shadaj.scalapy.py

almond.scalapy.initDisplay

// Workaround becasue neither `plot.show()` nor `display.display(plot.gcf())` work
def showPlot(plot: py.Dynamic): py.Dynamic = {
  val io = py.module("io")
  val buffer = io.BytesIO()
  plot.savefig(buffer, format = "png")
  buffer.seek(0)
  val display = py.module("IPython.display")
  display.Image(buffer.read())
}