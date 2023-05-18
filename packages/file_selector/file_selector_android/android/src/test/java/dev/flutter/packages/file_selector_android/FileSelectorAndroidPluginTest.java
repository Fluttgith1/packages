// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package dev.flutter.packages.file_selector_android;

import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import android.app.Activity;
import android.content.ClipData;
import android.content.ContentResolver;
import android.content.Intent;
import android.database.Cursor;
import android.net.Uri;
import android.os.Build;
import android.provider.OpenableColumns;
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.PluginRegistry;
import java.io.DataInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Collections;
import java.util.List;
import org.junit.Assert;
import org.junit.Rule;
import org.junit.Test;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnit;
import org.mockito.junit.MockitoRule;

public class FileSelectorAndroidPluginTest {
  @Rule public MockitoRule mockitoRule = MockitoJUnit.rule();

  @Mock public Intent mockIntent;

  @Mock public Activity mockActivity;

  @Mock FileSelectorApiImpl.TestProxy mockTestProxy;

  @Mock public ActivityPluginBinding mockActivityBinding;

  private void mockContentResolver(
      @NonNull ContentResolver mockResolver,
      @NonNull Uri uri,
      @NonNull String displayName,
      int size,
      @NonNull String mimeType)
      throws FileNotFoundException {
    final Cursor mockCursor = mock(Cursor.class);
    when(mockCursor.moveToFirst()).thenReturn(true);

    when(mockCursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)).thenReturn(0);
    when(mockCursor.getString(0)).thenReturn(displayName);

    when(mockCursor.getColumnIndex(OpenableColumns.SIZE)).thenReturn(1);
    when(mockCursor.isNull(1)).thenReturn(false);
    when(mockCursor.getInt(1)).thenReturn(size);

    when(mockResolver.query(uri, null, null, null, null, null)).thenReturn(mockCursor);
    when(mockResolver.getType(uri)).thenReturn(mimeType);
    when(mockResolver.openInputStream(uri)).thenReturn(mock(InputStream.class));
  }

  @SuppressWarnings("JavaReflectionMemberAccess")
  private static <T> void setFinalStatic(
      Class<T> classToModify, String fieldName, Object newValue) {
    try {
      Field field = classToModify.getField(fieldName);
      field.setAccessible(true);

      Field modifiersField = Field.class.getDeclaredField("modifiers");
      modifiersField.setAccessible(true);
      modifiersField.setInt(field, field.getModifiers() & ~Modifier.FINAL);

      field.set(null, newValue);
    } catch (Exception e) {
      Assert.fail("Unable to mock static field: " + fieldName);
    }
  }

  @SuppressWarnings({"rawtypes", "unchecked"})
  @Test
  public void openFileReturnsSuccessfully() throws FileNotFoundException {
    final ContentResolver mockContentResolver = mock(ContentResolver.class);

    final Uri mockUri = mock(Uri.class);
    when(mockUri.toString()).thenReturn("some/path/");
    mockContentResolver(mockContentResolver, mockUri, "filename", 30, "text/plain");

    when(mockTestProxy.newIntent(Intent.ACTION_OPEN_DOCUMENT)).thenReturn(mockIntent);
    when(mockTestProxy.newDataInputStream(any())).thenReturn(mock(DataInputStream.class));
    when(mockActivity.getContentResolver()).thenReturn(mockContentResolver);
    when(mockActivityBinding.getActivity()).thenReturn(mockActivity);
    final FileSelectorApiImpl fileSelectorApi =
        new FileSelectorApiImpl(mockActivityBinding, mockTestProxy);

    final GeneratedFileSelectorApi.Result mockResult = mock(GeneratedFileSelectorApi.Result.class);
    fileSelectorApi.openFile(null, Collections.emptyList(), Collections.emptyList(), mockResult);
    verify(mockIntent).addCategory(Intent.CATEGORY_OPENABLE);

    verify(mockActivity).startActivityForResult(mockIntent, 221);

    final ArgumentCaptor<PluginRegistry.ActivityResultListener> listenerArgumentCaptor =
        ArgumentCaptor.forClass(PluginRegistry.ActivityResultListener.class);
    verify(mockActivityBinding).addActivityResultListener(listenerArgumentCaptor.capture());

    final Intent resultMockIntent = mock(Intent.class);
    when(resultMockIntent.getData()).thenReturn(mockUri);
    listenerArgumentCaptor.getValue().onActivityResult(221, Activity.RESULT_OK, resultMockIntent);

    final ArgumentCaptor<GeneratedFileSelectorApi.FileResponse> fileCaptor =
        ArgumentCaptor.forClass(GeneratedFileSelectorApi.FileResponse.class);
    verify(mockResult).success(fileCaptor.capture());

    final GeneratedFileSelectorApi.FileResponse file = fileCaptor.getValue();
    assertEquals(file.getBytes().length, 30);
    assertEquals(file.getMimeType(), "text/plain");
    assertEquals(file.getName(), "filename");
    assertEquals(file.getSize(), (Long) 30L);
    assertEquals(file.getPath(), "some/path/");
  }

  @SuppressWarnings({"rawtypes", "unchecked"})
  @Test
  public void openFilesReturnsSuccessfully() throws FileNotFoundException {
    final ContentResolver mockContentResolver = mock(ContentResolver.class);

    final Uri mockUri = mock(Uri.class);
    when(mockUri.toString()).thenReturn("some/path/");
    mockContentResolver(mockContentResolver, mockUri, "filename", 30, "text/plain");

    final Uri mockUri2 = mock(Uri.class);
    when(mockUri2.toString()).thenReturn("some/other/path/");
    mockContentResolver(mockContentResolver, mockUri2, "filename2", 40, "image/jpg");

    when(mockTestProxy.newIntent(Intent.ACTION_OPEN_DOCUMENT)).thenReturn(mockIntent);
    when(mockTestProxy.newDataInputStream(any())).thenReturn(mock(DataInputStream.class));
    when(mockActivity.getContentResolver()).thenReturn(mockContentResolver);
    when(mockActivityBinding.getActivity()).thenReturn(mockActivity);
    final FileSelectorApiImpl fileSelectorApi =
        new FileSelectorApiImpl(mockActivityBinding, mockTestProxy);

    final GeneratedFileSelectorApi.Result mockResult = mock(GeneratedFileSelectorApi.Result.class);
    fileSelectorApi.openFiles(null, Collections.emptyList(), Collections.emptyList(), mockResult);
    verify(mockIntent).addCategory(Intent.CATEGORY_OPENABLE);
    verify(mockIntent).putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true);

    verify(mockActivity).startActivityForResult(mockIntent, 222);

    final ArgumentCaptor<PluginRegistry.ActivityResultListener> listenerArgumentCaptor =
        ArgumentCaptor.forClass(PluginRegistry.ActivityResultListener.class);
    verify(mockActivityBinding).addActivityResultListener(listenerArgumentCaptor.capture());

    final Intent resultMockIntent = mock(Intent.class);
    final ClipData mockClipData = mock(ClipData.class);
    when(mockClipData.getItemCount()).thenReturn(2);

    final ClipData.Item mockClipDataItem = mock(ClipData.Item.class);
    when(mockClipDataItem.getUri()).thenReturn(mockUri);
    when(mockClipData.getItemAt(0)).thenReturn(mockClipDataItem);

    final ClipData.Item mockClipDataItem2 = mock(ClipData.Item.class);
    when(mockClipDataItem2.getUri()).thenReturn(mockUri2);
    when(mockClipData.getItemAt(1)).thenReturn(mockClipDataItem2);

    when(resultMockIntent.getClipData()).thenReturn(mockClipData);

    listenerArgumentCaptor.getValue().onActivityResult(222, Activity.RESULT_OK, resultMockIntent);

    final ArgumentCaptor<List> fileListCaptor = ArgumentCaptor.forClass(List.class);
    verify(mockResult).success(fileListCaptor.capture());

    final List<GeneratedFileSelectorApi.FileResponse> fileList = fileListCaptor.getValue();
    assertEquals(fileList.get(0).getBytes().length, 30);
    assertEquals(fileList.get(0).getMimeType(), "text/plain");
    assertEquals(fileList.get(0).getName(), "filename");
    assertEquals(fileList.get(0).getSize(), (Long) 30L);
    assertEquals(fileList.get(0).getPath(), "some/path/");

    assertEquals(fileList.get(1).getBytes().length, 40);
    assertEquals(fileList.get(1).getMimeType(), "image/jpg");
    assertEquals(fileList.get(1).getName(), "filename2");
    assertEquals(fileList.get(1).getSize(), (Long) 40L);
    assertEquals(fileList.get(1).getPath(), "some/other/path/");
  }

  @SuppressWarnings({"rawtypes", "unchecked"})
  @Test
  public void getDirectoryPathReturnsSuccessfully() {
    setFinalStatic(Build.VERSION.class, "SDK_INT", Build.VERSION_CODES.LOLLIPOP);

    final Uri mockUri = mock(Uri.class);
    when(mockUri.toString()).thenReturn("some/path/");

    when(mockTestProxy.newIntent(Intent.ACTION_OPEN_DOCUMENT_TREE)).thenReturn(mockIntent);
    when(mockActivityBinding.getActivity()).thenReturn(mockActivity);
    final FileSelectorApiImpl fileSelectorApi =
        new FileSelectorApiImpl(mockActivityBinding, mockTestProxy);

    final GeneratedFileSelectorApi.Result mockResult = mock(GeneratedFileSelectorApi.Result.class);
    fileSelectorApi.getDirectoryPath(null, mockResult);

    verify(mockActivity).startActivityForResult(mockIntent, 223);

    final ArgumentCaptor<PluginRegistry.ActivityResultListener> listenerArgumentCaptor =
        ArgumentCaptor.forClass(PluginRegistry.ActivityResultListener.class);
    verify(mockActivityBinding).addActivityResultListener(listenerArgumentCaptor.capture());

    final Intent resultMockIntent = mock(Intent.class);
    when(resultMockIntent.getData()).thenReturn(mockUri);
    listenerArgumentCaptor.getValue().onActivityResult(223, Activity.RESULT_OK, resultMockIntent);

    verify(mockResult).success("some/path/");
  }
}
