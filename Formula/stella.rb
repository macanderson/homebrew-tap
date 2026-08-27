# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.255 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.9.255"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.255/stella-0.9.255-aarch64-apple-darwin.tar.gz"
      sha256 "e2299a4ddbc76a2830aab2fc35262ee38740993f1fd239b895eeca0875fafac6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.255/stella-0.9.255-x86_64-apple-darwin.tar.gz"
      sha256 "5b6da951d8fdc8341b708b45302f339e8764f1b53f09a6e44bc18409174f1cd6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.255/stella-0.9.255-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e5ab363aaa8b47a428f902e894fafa1b5fc76b0ee23e38401095df111d47f0e8"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.255/stella-0.9.255-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d2476e8c81f6ad6a15773d34c8b9595b491d219c417309c2051d496e9338b913"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end
