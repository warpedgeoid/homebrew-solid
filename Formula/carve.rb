class Carve < Formula
  desc "Carve is a fast, robust constructive solid geometry library."
  homepage "http://code.google.com/p/carve"
  head "https://github.com/qnzhou/carve.git"

  option "with-gui", "Build with GUI support."

  depends_on "cmake" => :build
  depends_on "boost"

  depends_on "glew" if build.with? "gui"

  def install
        cmake_args = %W[
          -DBUILD_SHARED_LIBS=ON
        ]

        # include GL, GLEW and GLUT checks if built with GUI support.
        cmake_args << "-DCARVE_WITH_GUI=ON" if build.with? "gui"

        cd "build" do
          system "cmake", "..", *std_cmake_args, *cmake_args
          system "make"
          system "make", "install"
        end
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test carve`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
