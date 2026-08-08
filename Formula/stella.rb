# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.14 / @SHA_*@ placeholders below with
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
  version "0.7.14"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.14/stella-0.7.14-aarch64-apple-darwin.tar.gz"
      sha256 "5396ef34f5c6ee8e9c2a2382f493360ea64997202c7e993efc9818693eddbd31"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.14/stella-0.7.14-x86_64-apple-darwin.tar.gz"
      sha256 "37de307f8e6265835985e8caf8ea91c8a9476398eefe3885941b11ea34eabcac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.14/stella-0.7.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9aeeece922a665fae921b96c6a00bad4ef3dbdda92cb1e92cdd18018b65c893a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.14/stella-0.7.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "75270f9f36240a3a2fca3c3fc06490a2d7ac62e2016ca3a6c99835e9f983a011"
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
