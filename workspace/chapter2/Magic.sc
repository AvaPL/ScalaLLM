import os._

object ! {
  def apply(args: String*): Unit =
    print(os.proc(args).call(
      stdout = os.ProcessOutput.Readlines(println),
      stderr = os.ProcessOutput.Readlines(Console.err.println)
    ).out.text())
}