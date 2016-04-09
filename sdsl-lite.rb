class SdslLite < Formula
  desc "Succinct Data Structure Library 2.0"
  homepage "https://github.com/simongog/sdsl-lite"
  # doi "arXiv:1311.1249v1"
  # tag "bioinformatics"

  url "https://github.com/simongog/sdsl-lite/archive/v2.0.3.tar.gz"
  sha256 "08ece40ce44041906bfa425af81a20a8071d187285f674debd8816c2e3113c2f"

  head "https://github.com/simongog/sdsl-lite.git"

  # this library is now part of SDSL - should remove the formula?
  conflicts_with "libdivsufsort"

  needs :cxx11

  depends_on "cmake" => :build

  def install
    ENV.cxx11
    system "./install.sh", prefix
    pkgshare.install "examples", "extras", "tutorial"
  end

  test do
    ENV.cxx11
    exe = "fm-index"
    system *ENV.cxx.split, "-o", exe,
      "-I#{opt_include}", pkgshare/"examples/fm-index.cpp",
      "-L#{opt_lib}", "-lsdsl", "-ldivsufsort", "-ldivsufsort64"
    assert_match "FM-index", shell_output("./#{exe} 2>&1", 1)
  end
end
