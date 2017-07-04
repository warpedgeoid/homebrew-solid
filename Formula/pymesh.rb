class Pymesh < Formula
  desc "PyMesh is a rapid prototyping platform focused on geometry processing."
  homepage "http://pymesh.readthedocs.org/en/latest/"
  url "https://github.com/qnzhou/PyMesh/archive/v0.1.zip"
  head "https://github.com/qnzhou/PyMesh.git"
  sha256 ""

  depends_on "cmake" => :build
  depends_on "swig" => :build
  depends_on "boost"
  depends_on "eigen"
  depends_on :python => ["numpy", "scipy"]

  depends_on "google-sparsehash" => :recommended
  depends_on "tetgen" => :recommended
  depends_on "triangle" => :recommended
  depends_on "qhull" => :recommended
  depends_on "metis" => :recommended
  depends_on "warpedgeoid/solid/cgal@4.10" => :recommended
  depends_on "warpedgeoid/solid/libigl" => :recommended
  depends_on "warpedgeoid/solid/cork" => :recommended
  depends_on "warpedgeoid/solid/libpolyclipping" => :recommended
  depends_on "warpedgeoid/solid/carve" => :recommended

  def install
      inreplace "cmake/FindTetgen.cmake", "FIND_LIBRARY(TETGEN_LIBRARIES tetgen", 
        "FIND_LIBRARY(TETGEN_LIBRARIES NAMES tetgen tet"
      mkdir "build" do
        system "cmake", "..", *std_cmake_args
        system "make"
        system "make", "src_tests"
        system "make", "tools"
        system "make", "tools_tests"
      end
      system "python", "setup.py", "build"
      system "python", "setup.py", "install"
  end

  test do
    system "python", "-c", "import pymesh; pymesh.test()"
  end
end
