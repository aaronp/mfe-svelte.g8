package bar

import org.scalatest.{BeforeAndAfterAll, Matchers, WordSpec}

abstract class BaseSpec extends WordSpec with Matchers with BeforeAndAfterAll
