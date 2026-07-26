# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.49 / @SHA_*@ placeholders below with
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
  version "0.5.49"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.49/stella-0.5.49-aarch64-apple-darwin.tar.gz"
      sha256 "68be10b18001f17fe2280c14546b6aa98b24e3a8b5b24c04e57bec534c57109b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.49/stella-0.5.49-x86_64-apple-darwin.tar.gz"
      sha256 "5709914e9078b1c8de990861b72b6bb06d0c2eba33aba48e462cd166b8851ace"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.49/stella-0.5.49-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "78c28320e322bf263ce7c8d2aa965642668160ac56e816cfa601cf651cd7d273"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.49/stella-0.5.49-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "934a1bbd24b305db94ecd146381b7614483d49f15ddeb38a5e48066d8b239bfe"
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
