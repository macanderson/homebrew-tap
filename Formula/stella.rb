# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.483 / @SHA_*@ placeholders below with
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
  version "0.9.483"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.483/stella-0.9.483-aarch64-apple-darwin.tar.gz"
      sha256 "f6fd74b73b8c4e2677255b94ded07d50a50ed61554e22e34f439caf680198e8a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.483/stella-0.9.483-x86_64-apple-darwin.tar.gz"
      sha256 "bb4169cef4e43478d618eb7348ac1429ed6a42ce1658c013677db19f2fb6ec6a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.483/stella-0.9.483-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "08db007e52b5c930a726bf4fdf6881040a81cd1b4706e3bb4e61d830aefe4960"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.483/stella-0.9.483-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d980f5783df1afa31a44641faaa80d1b1aaa22291527cb9bb6d38296325a03c3"
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
