# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.115 / @SHA_*@ placeholders below with
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
  version "0.6.115"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.115/stella-0.6.115-aarch64-apple-darwin.tar.gz"
      sha256 "9606be484af3e1fa849d8833b57359d3cfdb2b96af546ac9ad8e47b341da80ce"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.115/stella-0.6.115-x86_64-apple-darwin.tar.gz"
      sha256 "b783bae29b2ab6c55314e656367cf539bc1856fb1bd460871cb73a652d734b42"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.115/stella-0.6.115-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "45b862431c9f3424c35b061b0b5724a588ec315d33c32277a6695b72daa44cae"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.115/stella-0.6.115-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fed417d0bcc0dbb3d94f3dfc2fbfdfc5c857444a87e9c30b8cd0c22808cb4c8a"
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
