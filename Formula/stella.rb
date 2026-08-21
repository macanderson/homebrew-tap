# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.123 / @SHA_*@ placeholders below with
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
  version "0.9.123"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.123/stella-0.9.123-aarch64-apple-darwin.tar.gz"
      sha256 "9aa83395319f9f503d3733908b8b73aaf3f74d06a28c77d2b30834ab7f2235a3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.123/stella-0.9.123-x86_64-apple-darwin.tar.gz"
      sha256 "526921ca3126edb92bbed27209393879ca4f42e751e2ff9b709ea4eff3d30d15"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.123/stella-0.9.123-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e577575921313bb57cbf00406751b6c6a33279acf0d327fe79fade19d7b5fc8e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.123/stella-0.9.123-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b4eedc01dd898a22478ebf064f1afd8be0920d191fbdd7afe560cedc3cf7d546"
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
