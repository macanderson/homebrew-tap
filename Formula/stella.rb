# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.295 / @SHA_*@ placeholders below with
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
  version "0.9.295"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.295/stella-0.9.295-aarch64-apple-darwin.tar.gz"
      sha256 "2889687a3568c9fbd82a9813f5eb0716f0b98dd89aa0ea8d0bb7ecf3c73c839e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.295/stella-0.9.295-x86_64-apple-darwin.tar.gz"
      sha256 "982556a9fa69af32bf3ba9777b9da3eb1f0f270baa395dc6ec7a60312736b87e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.295/stella-0.9.295-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "810c9cfca7ef6effad70414a30d992c720cd1f566a7fe0c9bcad59e3bba68a51"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.295/stella-0.9.295-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "85a20c09eb1f11e9a94067542b773d525325f6ac11027a514078852f03766a27"
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
