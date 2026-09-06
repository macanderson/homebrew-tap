# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.359 / @SHA_*@ placeholders below with
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
  version "0.9.359"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.359/stella-0.9.359-aarch64-apple-darwin.tar.gz"
      sha256 "09de0c35acdc3e404e35726a9de01b8b4218ac9f6920bd37ed1ec61e49f17bb9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.359/stella-0.9.359-x86_64-apple-darwin.tar.gz"
      sha256 "f3abd488098642549e04573e1639058529321d2ccf1431f7995100c8abe484a1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.359/stella-0.9.359-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9e84e2cf6b61424b4dba7e043a7344c52807d229ba16f396ef0e219f5fad4e8b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.359/stella-0.9.359-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d70a04c2b25fa697d1f145c22b2cc2dc3fcc0569a1fd237d802e21c3a718a94f"
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
