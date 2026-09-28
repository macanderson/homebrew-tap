# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.445 / @SHA_*@ placeholders below with
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
  version "0.9.445"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.445/stella-0.9.445-aarch64-apple-darwin.tar.gz"
      sha256 "e37aa9ecd211095a452fc1d052fae4aaa39307affda56dbfa15cd9ebaed387b0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.445/stella-0.9.445-x86_64-apple-darwin.tar.gz"
      sha256 "7cccefbd314a8047c4f1f29c71afa23d1d823e45535082d7910a13f1fba1eb13"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.445/stella-0.9.445-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8a29ef41a7e32dace4fa52f32cbba765a4469f5e5e21c115c83d3347e42a0d81"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.445/stella-0.9.445-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0be784449d584ab22226f035b058c83797c03d98f235fe9f322f0cd4520c3036"
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
