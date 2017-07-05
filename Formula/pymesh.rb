class Pymesh < Formula
  desc "PyMesh is a rapid prototyping platform focused on geometry processing."
  homepage "http://pymesh.readthedocs.org/en/latest/"

  url "https://github.com/qnzhou/PyMesh.git",
    :using => :git,
    :revision => "dad3119d867fd06019944a5dca890831549f18bb"

  # version is date-based due to git.
  version "20170704"

  head "https://github.com/qnzhou/PyMesh.git"

  depends_on "cmake" => :build
  depends_on "swig" => :build
  depends_on "boost"
  depends_on "eigen"
  depends_on :python => ["numpy", "scipy"]
  depends_on "google-sparsehash" => :recommended
  depends_on "homebrew/science/suite-sparse"
  depends_on "quartet" => :recommended
  depends_on "tetgen" => :recommended
  depends_on "triangle" => :recommended
  depends_on "qhull" => :recommended
  depends_on "metis" => :recommended
  depends_on "tinyxml2" => :recommended
  depends_on "warpedgeoid/solid/cgal@4.10" => :recommended
  depends_on "warpedgeoid/solid/libigl" => :recommended
  depends_on "warpedgeoid/solid/cork" => :recommended
  depends_on "warpedgeoid/solid/libpolyclipping" => :recommended
  depends_on "warpedgeoid/solid/carve" => :recommended

  def install
    ENV["EIGEN_INC"] = Formula["eigen"].opt_prefix
    ENV["BOOST_INC"] = Formula["boost"].opt_prefix
    ENV["CGAL_PATH"] = Formula["cgal@4.10"].opt_prefix
    ENV["GOOGLEHASH_INCLUDES"] = Formula["google-sparsehash"].opt_prefix
    ENV["LIBIGL_PATH"] = Formula["libigl"].opt_prefix
    ENV["CORK_PATH"] = Formula["cork"].opt_prefix
    ENV["TETGEN_PATH"] = Formula["tetgen"].opt_prefix
    ENV["TRIANGLE_PATH"] = Formula["triangle"].opt_prefix
    ENV["QHULL_PATH"] = Formula["qhull"].opt_prefix
    ENV["CLIPPER_PATH"] = Formula["libpolyclipping"].opt_prefix
    ENV["CARVE_PATH"] = Formula["carve"].opt_prefix
    ENV["METIS_PATH"] = Formula["metis"].opt_prefix
    ENV["SUITESPARSE_ROOT"] = Formula["suite-sparse"].opt_prefix

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "src_tests"
      system "make", "tools"
      system "make", "tools_tests"
    end

    system "python", *Language::Python.setup_install_args(prefix)
    doc.install Dir["docs/*"]
  end

  test do
    system "python", "-c", "import pymesh; pymesh.test()"
  end
end
